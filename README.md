# Tooling we've built to upgrade Bootstrap 4
In spring 2020 [Retail Zipline](https://retail-zipline.breezy.hr) upgraded our UI framework to Bootstrap 4. Along the way, we built a variety of tools to help make the process easier. This is a collection of some of those custom tools.

This code is likely won't work as-is because it's specific to our code at the time, but is meant as an aid and reference.

## Command-Line Tools
- [bs4_migration_check](https://github.com/retailzipline/bootstrap-tooling/blob/master/bin/bs4_migration_check): status checker for how many views remain
- [bs4_start](https://github.com/retailzipline/bootstrap-tooling/blob/master/bin/bs4_start): copies files from one directory to another and commits them. Used to copy from `views` to `views_v2`.
- [bs4_upgrade](https://github.com/retailzipline/bootstrap-tooling/blob/master/bin/bs4_upgrade): upgrades a file or folder from existing classes to Bootstrap 4 classes. Intended to be run after `bs4_start`

## View Control
[ControllerViewV2Paths](https://github.com/retailzipline/bootstrap-tooling/blob/master/app/controllers/concerns/controller_view_v2_paths.rb) is a controller concern to enable a particular controller or action to render from another view folder. Specifically, when `v2_ready :show` is used, the `show` action will render from `views_v2` instead of `views`. When `v2_ready` is in the [application controller](https://github.com/retailzipline/bootstrap-tooling/blob/master/app/controllers/application_controller.rb), then all the new views are used.
