//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <circle_scroll/circle_scroll_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) circle_scroll_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CircleScrollPlugin");
  circle_scroll_plugin_register_with_registrar(circle_scroll_registrar);
}
