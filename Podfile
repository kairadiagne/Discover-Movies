# Global Configuration
platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def shared_pods
    pod 'SwiftLint'
end

target 'DiscoverMovies' do
    pod 'SDWebImage'
    pod 'ChameleonFramework'
    pod 'youtube-ios-player-helper'
    pod 'SWRevealViewController'
    pod 'BRYXBanner'
    pod 'SwiftLint'
end

target 'TMDbMovieKit' do
    pod 'Alamofire'
    pod 'Locksmith'
end

# Acknowledgement
#post_install do | installer |
#    require 'fileutils'
#    FileUtils.cp_r('Pods/Target Support Files/Pods-Networking-DiscoverMovies/Pods-Networking-DiscoverMovies-acknowledgements.plist', 'DiscoverMovies/Acknowledgements.plist', :remove_destination => true)
#end
