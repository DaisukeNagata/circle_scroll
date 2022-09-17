#ifndef FLUTTER_PLUGIN_CIRCLE_SCROLL_PLUGIN_H_
#define FLUTTER_PLUGIN_CIRCLE_SCROLL_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace circle_scroll {

class CircleScrollPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CircleScrollPlugin();

  virtual ~CircleScrollPlugin();

  // Disallow copy and assign.
  CircleScrollPlugin(const CircleScrollPlugin&) = delete;
  CircleScrollPlugin& operator=(const CircleScrollPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace circle_scroll

#endif  // FLUTTER_PLUGIN_CIRCLE_SCROLL_PLUGIN_H_
