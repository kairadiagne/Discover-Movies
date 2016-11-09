# Uncomment this line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

abstract_target 'Networking' do
    pod 'Alamofire'
    pod 'Locksmith'
    
    target 'Discover' do
        pod 'SDWebImage'
        pod 'ChameleonFramework'
        pod 'youtube-ios-player-helper'
        pod 'SWRevealViewController'
        pod 'BRYXBanner'
    end
    
    target 'TMDbMovieKit' do
    end
    
end

# Acknowledgement
post_install do | installer |
    require 'fileutils'
    FileUtils.cp_r('Pods/Target Support Files/Pods-Networking-Discover/Pods-Networking-Discover-acknowledgements.plist', 'Discover/Acknowledgements.plist', :remove_destination => true)
end
