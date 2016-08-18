<?php


use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class F1OGContext extends F1FundamentalContext implements SnippetAcceptingContext, Context {


  public function __construct() {
  }

  /**
   * Create user, organic group and og membership.
   *
   * @Given I am a/an :role of :og_title organic group of type :entity_type and bundle/vocabulary :bundle
   */
  public function assertMemberOfOrganicGroup($role, $og_title, $entity_type, $bundle) {
    $role = drupal_strtolower($role);

    if (empty($this->user)) {
      $user = (object) array(
        'name' => $this->getRandom()->name(8),
        'pass' => $this->getRandom()->name(16),
        'role' => $role,
      );
      $user->mail = "{$user->name}@example.com";
      $this->userCreate($user);
    }
    else {
      $user = $this->user;
    }
    $user = user_load_by_name($user->name);

    $path = '/' . $entity_type . '/';
    switch ($entity_type) {
      case 'node':
        $node = (object) [
          'title' => $og_title,
          'type' => $bundle,
          'uid' => $user->uid,
        ];
        $entity_id_name = 'nid';
        $saved = $this->nodeCreate($node);
        break;

      case 'term':
        $term = (object) [
          'name' => $og_title,
          'vocabulary_machine_name' => $bundle,
          'description' => $this->getRandom()->name(255),
          'uid' => $user->uid,
        ];
        $entity_id_name = 'tid';
        $path = '/taxonomy/term/';
        $saved = $this->termCreate($term);
        break;

      case 'user':
        $user = (object) [
          'name' => $og_title,
          'pass' => $this->getRandom()->name(16),
        ];
        $entity_id_name = 'uid';
        $saved = $this->userCreate($user);
        break;

      default:
        throw new \InvalidArgumentException(sprintf('No entity type definition exists for %s.', $entity_type));
    }

    // Login the user.
    $this->login();

    $membership = og_group($entity_type, $saved->{$entity_id_name}, [
      'entity type' => 'user',
      'entity' => $user,
    ]);

    $roles = array_flip(og_roles($entity_type, $bundle, $saved->{$entity_id_name}, FALSE, TRUE));
    if (empty($roles[$role])) {
      var_dump($roles);
      throw new \Exception(sprintf('There is no organic group role that exists with the name of %s', $role));
    }
    og_role_grant($entity_type, $saved->{$entity_id_name}, $user->uid, $roles[$role]);

    $this->getSession()->visit($this->locatePath('/' . $entity_type . '/' . $saved->{$entity_id_name}));
  }

  /**
   * Edits og content authored by the current user.
   *
   * @When I edit a/an :entity_type organic group
   */
  public function assertEditOrganicGroup($entity_type) {
    $path = ltrim(parse_url($this->getSession()->getCurrentUrl(), PHP_URL_PATH), '/');

    $position = 1;
    if ($entity_type == 'term') {
      $entity_type = 'taxonomy_term';
      $position = 2;
    }

    $menu_item = menu_get_item($path);
    if (isset($menu_item['load_functions'][$position]) && !empty($menu_item['original_map'][$position]) && $menu_item['load_functions'][$position] == $entity_type . '_load') {
      if (($entity = $menu_item['load_functions'][$position]($menu_item['original_map'][$position])) && og_is_group($entity_type, $entity)) {
        $this->getSession()->visit($this->locatePath($path . '/edit'));
      }
    }
    else {
      throw new \Exception(sprintf('No active organic group could be found at %.', $path));
    }
  }

}