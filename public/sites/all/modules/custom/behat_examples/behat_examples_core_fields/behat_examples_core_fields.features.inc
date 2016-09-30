<?php
/**
 * @file
 * behat_examples_core_fields.features.inc
 */

/**
 * Implements hook_node_info().
 */
function behat_examples_core_fields_node_info() {
  $items = array(
    'behat_boolean' => array(
      'name' => t('Boolean Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a boolean field to be used to illustrate Behat testing on a boolean field. '),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_core_fields' => array(
      'name' => t('Core Fields'),
      'base' => 'node_content',
      'description' => t('A multi-field content type used to illustrate Behat testing on a content type with multiple fields.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_file' => array(
      'name' => t('File'),
      'base' => 'node_content',
      'description' => t('A simple content type with a file field to be used to illustrate Behat testing on a file field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_float' => array(
      'name' => t('Float Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a float field to be used to illustrate Behat testing on a float field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_image' => array(
      'name' => t('Image'),
      'base' => 'node_content',
      'description' => t('A simple content type with an image field to be used to illustrate Behat testing on an image field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_integer' => array(
      'name' => t('Integer Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with an integer field to be used to illustrate Behat testing on an integer field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_list' => array(
      'name' => t('List Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a list field to be used to illustrate Behat testing on a list field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_lng_txt_sum' => array(
      'name' => t('Long Text with Summary'),
      'base' => 'node_content',
      'description' => t('A simple content type with a longtext with summary field to be used to illustrate Behat testing on a longtext with summary field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_longtext' => array(
      'name' => t('Long Text Field'),
      'base' => 'node_content',
      'description' => t('A simple content type with a longtext field to be used to illustrate Behat testing on a longtext field.'),
      'has_title' => '1',
      'title_label' => t('Title'),
      'help' => '',
    ),
    'behat_text' => array(
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
