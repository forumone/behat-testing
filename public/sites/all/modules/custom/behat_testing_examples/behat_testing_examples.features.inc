<?php
/**
 * @file
 * behat_testing_examples.features.inc
 */

/**
 * Implements hook_node_info().
 */
function behat_testing_examples_node_info() {
  $items = array(
    'boolean' => array(
      'name' => t('Boolean Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a boolean field to be used to illustrate Behat testing on a boolean field. '),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'file' => array(
      'name' => t('File'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'float' => array(
      'name' => t('Float Field'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'integer' => array(
      'name' => t('Integer Field'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'list' => array(
      'name' => t('List Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a list field to be used to illustrate Behat testing on a list field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'longtext' => array(
      'name' => t('Longtext Field'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'term_reference' => array(
      'name' => t('Term Reference'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'text' => array(
      'name' => t('Text Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a text field to be used to illustrate Behat testing on a text field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  drupal_alter('node_info', $items);
  return $items;
}
