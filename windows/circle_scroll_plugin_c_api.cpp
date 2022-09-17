#include "include/circle_scroll/circle_scroll_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "circle_scroll_plugin.h"

void CircleScrollPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  circle_scroll::CircleScrollPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
