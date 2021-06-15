
# as_ao_display_string_dates

An ArchivesSpace plugin that makes the inclusion of dates in ArchivalObject
display strings configurable.

This is currently just a quick sketch developed against AS v2.8.1.


### Known Issues

Whenever this plugin is installed or its configuration is changed it will be
necessary to reindex all ArchivalObjects.

This hasn't yet been implemented for DigitalObjectComponents.

It ignores the stored display_string, so if you uninstall this plugin it will
just revert to using the stored one.

There may be places in AS that rely on the stored display_string.


## Configuration

By default it will produce display strings like pre v2.8.0 (only the first date
and using expression or begin - end)

This behavior can be changed in config like this:

```ruby
  AppConfig[:as_ao_display_string_dates] = {
    :selector => proc{|dates| dates},
    :builder => proc{|date| date['begin']}
  }
```

Where the `:selector` key allows you to determine which dates should be included
in the display string (all of them in the example).

And the `:builder` key allows you to override how a date is represented in the
display string (just the begin date in the example).

Both keys are optional.



&copy; 2021 Hudson Molonglo Pty Ltd
