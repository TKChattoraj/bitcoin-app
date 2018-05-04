# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'
require 'motion/project'
require 'rubygems'

require 'motion-cocoapods'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BCTest'

  app.info_plist['CFBundleIconName'] = 'AppIcon'
  app.info_plist['NSAppTransportSecurity'] = {'NSAllowsArbitraryLoads' => true}

  app.pods do
  #app.pods :headers_dir => 'Headers/AFNetworking' do
    #use_frameworks!
    pod 'AFNetworking'
    pod 'CoreBitcoin'

  end

end

# Track and specify files and their mutual dependencies within the :motion
# Bundler group
#MotionBundler.setup
