<?php
/**
 * @file
 * behat_test_feature.features.inc
 */

/**
 * Implements hook_node_info().
 */
function behat_test_feature_node_info() {
  $items = array(
    'behat_test_content_type' => array(
      'name' => t('Behat Test Content Type'),
      'base' => 'node_content',
      'description' => '',
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
  );
  drupal_alter('node_info', $items);
  return $items;
}
