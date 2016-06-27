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
      'name' => t('Boolean'),
      'base' => 'node_content',
      'description' => t('A simple content type with a boolean field to be used to illustrate Behat testing on a boolean field. '),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'list' => array(
      'name' => t('List'),
      'base' => 'node_content',
      'description' => t('A simple content type with a list field to be used to illustrate Behat testing on a list field.'),
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
