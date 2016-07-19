<?php
/**
 * @file
 * behat_examples_views.views_default.inc
 */

/**
 * Implements hook_views_default_views().
 */
function behat_examples_views_views_default_views() {
  $export = array();

  $view = new view();
  $view->name = 'behat_examples_core_fields_view';
  $view->description = '';
  $view->tag = 'default';
  $view->base_table = 'node';
  $view->human_name = 'Behat Examples Core Fields View';
  $view->core = 7;
  $view->api_version = '3.0';
  $view->disabled = FALSE; /* Edit this to true to make a default view disabled initially */

  /* Display: Master */
  $handler = $view->new_display('default', 'Master', 'default');
  $handler->display->display_options['title'] = 'Behat Examples Core Fields View';
  $handler->display->display_options['use_more_always'] = FALSE;
  $handler->display->display_options['access']['type'] = 'perm';
  $handler->display->display_options['cache']['type'] = 'none';
  $handler->display->display_options['query']['type'] = 'views_query';
  $handler->display->display_options['exposed_form']['type'] = 'basic';
  $handler->display->display_options['pager']['type'] = 'full';
  $handler->display->display_options['pager']['options']['items_per_page'] = '5';
  $handler->display->display_options['style_plugin'] = 'default';
  $handler->display->display_options['row_plugin'] = 'fields';
  /* Field: Content: Title */
  $handler->display->display_options['fields']['title']['id'] = 'title';
  $handler->display->display_options['fields']['title']['table'] = 'node';
  $handler->display->display_options['fields']['title']['field'] = 'title';
  $handler->display->display_options['fields']['title']['label'] = '';
  $handler->display->display_options['fields']['title']['alter']['word_boundary'] = FALSE;
  $handler->display->display_options['fields']['title']['alter']['ellipsis'] = FALSE;
  /* Field: Content: Body */
  $handler->display->display_options['fields']['body']['id'] = 'body';
  $handler->display->display_options['fields']['body']['table'] = 'field_data_body';
  $handler->display->display_options['fields']['body']['field'] = 'body';
  /* Field: Content: Boolean */
  $handler->display->display_options['fields']['field_boolean']['id'] = 'field_boolean';
  $handler->display->display_options['fields']['field_boolean']['table'] = 'field_data_field_boolean';
  $handler->display->display_options['fields']['field_boolean']['field'] = 'field_boolean';
  /* Field: Content: Float */
  $handler->display->display_options['fields']['field_float']['id'] = 'field_float';
  $handler->display->display_options['fields']['field_float']['table'] = 'field_data_field_float';
  $handler->display->display_options['fields']['field_float']['field'] = 'field_float';
  $handler->display->display_options['fields']['field_float']['settings'] = array(
    'thousand_separator' => '',
    'decimal_separator' => '.',
    'scale' => '2',
    'prefix_suffix' => 1,
  );
  /* Field: Content: Image */
  $handler->display->display_options['fields']['field_image']['id'] = 'field_image';
  $handler->display->display_options['fields']['field_image']['table'] = 'field_data_field_image';
  $handler->display->display_options['fields']['field_image']['field'] = 'field_image';
  $handler->display->display_options['fields']['field_image']['click_sort_column'] = 'fid';
  $handler->display->display_options['fields']['field_image']['settings'] = array(
    'image_style' => '',
    'image_link' => '',
  );
  /* Field: Content: Integer */
  $handler->display->display_options['fields']['field_integer']['id'] = 'field_integer';
  $handler->display->display_options['fields']['field_integer']['table'] = 'field_data_field_integer';
  $handler->display->display_options['fields']['field_integer']['field'] = 'field_integer';
  $handler->display->display_options['fields']['field_integer']['settings'] = array(
    'thousand_separator' => '',
    'prefix_suffix' => 1,
  );
  /* Field: Content: List */
  $handler->display->display_options['fields']['field_list_text']['id'] = 'field_list_text';
  $handler->display->display_options['fields']['field_list_text']['table'] = 'field_data_field_list_text';
  $handler->display->display_options['fields']['field_list_text']['field'] = 'field_list_text';
  $handler->display->display_options['fields']['field_list_text']['delta_offset'] = '0';
  /* Field: Content: Term Reference */
  $handler->display->display_options['fields']['field_term_reference']['id'] = 'field_term_reference';
  $handler->display->display_options['fields']['field_term_reference']['table'] = 'field_data_field_term_reference';
  $handler->display->display_options['fields']['field_term_reference']['field'] = 'field_term_reference';
  $handler->display->display_options['fields']['field_term_reference']['delta_offset'] = '0';
  /* Field: Content: Text */
  $handler->display->display_options['fields']['field_text']['id'] = 'field_text';
  $handler->display->display_options['fields']['field_text']['table'] = 'field_data_field_text';
  $handler->display->display_options['fields']['field_text']['field'] = 'field_text';
  /* Sort criterion: Content: Title */
  $handler->display->display_options['sorts']['title']['id'] = 'title';
  $handler->display->display_options['sorts']['title']['table'] = 'node';
  $handler->display->display_options['sorts']['title']['field'] = 'title';
  /* Filter criterion: Content: Published */
  $handler->display->display_options['filters']['status']['id'] = 'status';
  $handler->display->display_options['filters']['status']['table'] = 'node';
  $handler->display->display_options['filters']['status']['field'] = 'status';
  $handler->display->display_options['filters']['status']['value'] = 1;
  $handler->display->display_options['filters']['status']['group'] = 1;
  $handler->display->display_options['filters']['status']['expose']['operator'] = FALSE;
  /* Filter criterion: Content: Type */
  $handler->display->display_options['filters']['type']['id'] = 'type';
  $handler->display->display_options['filters']['type']['table'] = 'node';
  $handler->display->display_options['filters']['type']['field'] = 'type';
  $handler->display->display_options['filters']['type']['value'] = array(
    'core_fields' => 'core_fields',
  );

  /* Display: Page */
  $handler = $view->new_display('page', 'Page', 'page');
  $handler->display->display_options['path'] = 'behat-examples-core-fields-view';
  $export['behat_examples_core_fields_view'] = $view;

  return $export;
}
