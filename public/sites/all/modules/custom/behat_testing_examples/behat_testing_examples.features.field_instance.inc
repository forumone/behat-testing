<?php
/**
 * @file
 * behat_testing_examples.features.field_instance.inc
 */

/**
 * Implements hook_field_default_field_instances().
 */
function behat_testing_examples_field_default_field_instances() {
  $field_instances = array();

  // Exported field_instance: 'node-boolean-field_boolean'.
  $field_instances['node-boolean-field_boolean'] = array(
    'bundle' => 'boolean',
    'default_value' => array(
      0 => array(
        'value' => 0,
      ),
    ),
    'deleted' => 0,
    'description' => 'Enter yes or no',
    'display' => array(
      'default' => array(
        'label' => 'above',
        'module' => 'list',
        'settings' => array(),
        'type' => 'list_default',
        'weight' => 0,
      ),
      'teaser' => array(
        'label' => 'above',
        'settings' => array(),
        'type' => 'hidden',
        'weight' => 0,
      ),
    ),
    'entity_type' => 'node',
    'field_name' => 'field_boolean',
    'label' => 'Boolean',
    'required' => 0,
    'settings' => array(
      'user_register_form' => FALSE,
    ),
    'widget' => array(
      'active' => 1,
      'module' => 'options',
      'settings' => array(
        'display_label' => 0,
      ),
      'type' => 'options_buttons',
      'weight' => -4,
    ),
  );

  // Exported field_instance: 'node-list-field_list_text'.
  $field_instances['node-list-field_list_text'] = array(
    'bundle' => 'list',
    'default_value' => NULL,
    'deleted' => 0,
    'description' => 'Select a color from the field below',
    'display' => array(
      'default' => array(
        'label' => 'above',
        'module' => 'list',
        'settings' => array(),
        'type' => 'list_default',
        'weight' => 0,
      ),
      'teaser' => array(
        'label' => 'above',
        'settings' => array(),
        'type' => 'hidden',
        'weight' => 0,
      ),
    ),
    'entity_type' => 'node',
    'field_name' => 'field_list_text',
    'label' => 'List Text',
    'required' => 0,
    'settings' => array(
      'user_register_form' => FALSE,
    ),
    'widget' => array(
      'active' => 1,
      'module' => 'options',
      'settings' => array(),
      'type' => 'options_select',
      'weight' => -4,
    ),
  );

  // Exported field_instance: 'node-text-field_text'.
  $field_instances['node-text-field_text'] = array(
    'bundle' => 'text',
    'default_value' => NULL,
    'deleted' => 0,
    'description' => 'Fill out the text field above with text values',
    'display' => array(
      'default' => array(
        'label' => 'above',
        'module' => 'text',
        'settings' => array(),
        'type' => 'text_default',
        'weight' => 0,
      ),
      'teaser' => array(
        'label' => 'above',
        'settings' => array(),
        'type' => 'hidden',
        'weight' => 0,
      ),
    ),
    'entity_type' => 'node',
    'field_name' => 'field_text',
    'label' => 'Text',
    'required' => 0,
    'settings' => array(
      'text_processing' => 0,
      'user_register_form' => FALSE,
    ),
    'widget' => array(
      'active' => 1,
      'module' => 'text',
      'settings' => array(
        'size' => 60,
      ),
      'type' => 'text_textfield',
      'weight' => -4,
    ),
  );

  // Translatables
  // Included for use with string extractors like potx.
  t('Boolean');
  t('Enter yes or no');
  t('Fill out the text field above with text values');
  t('List Text');
  t('Select a color from the field below');
  t('Text');

  return $field_instances;
}
