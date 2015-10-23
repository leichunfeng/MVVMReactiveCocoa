# MVVMReactiveCocoa

This repository contains the source code for the [GitBucket](https://itunes.apple.com/cn/app/id961330940?mt=8) iOS app. It is a mobile client app for GitHub, built using [MVVM](http://en.wikipedia.org/wiki/Model_View_ViewModel) architectural pattern and some awesome frameworks, such as [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)、[Mantle](https://github.com/MantleFramework/Mantle)、[octokit.objc](https://github.com/octokit/octokit.objc), etc. You can use it for any purpose, free of charge.

# Purpose

The purpose that I developing this app is hope to provide a complete app which is developed using the MVVM architectural pattern and RAC framework, and can help some iOS developers who want to use this technology.

Now, GitBucket mainly include the following features:

1. View Owned & Starred repos, repo's README and source code.
2. View Followers & Following, Follow & Unfollow user.
3. Search repos, Star & Unstar repo.

The features is little now, but I will add more utility features at the iterative development in the future, such as **Activity**、**Gists**、**Issues**, etc.

# Class diagram

![MVVMReactiveCocoa](OmniGraffle/MVVMReactiveCocoa.png "MVVMReactiveCocoa")

# Contribution

If you want to make some contributions to this project or just want to build the project, please using the following command:

```
git clone --recursive https://github.com/leichunfeng/MVVMReactiveCocoa.git
```

Everything will be done for you, and all you need to do is just waiting for it to finished. 

Once finished, you can open the project through double-click the `MVVMReactiveCocoa.xcworkspace` file and build the `MVVMReactiveCocoa` target. Any pull request will be welcome.

# License

MVVMReactiveCocoa is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
