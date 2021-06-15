
# as_display_string_dates

An ArchivesSpace plugin that makes the inclusion of dates in ArchivalObject
display strings configurable.

This is currently just a quick sketch developed against AS v2.8.1.


### Known Issues

Whenever this plugin is installed or its configuration is changed it will be
necessary to update all ArchivalObjects. Should write a background job to
do this.

This hasn't yet been implemented for DigitalObjectComponents.


## Configuration

By default it will produce display strings like v2.8.x (all dates
concatenated with ',', using: [bulk] (expression | begin - end))

This behavior can be changed in config like this:

```ruby
  AppConfig[:as_display_string_dates] = {
    :selector => proc{|dates| dates.first},
    :builder => proc{|date| date['begin']}
  }
```

Where the `:selector` key allows you to determine which dates should be included
in the display string (just the first in the example).

And the `:builder` key allows you to override how a date is represented in the
display string (just the begin date in the example).

Both keys are optional.



&copy; 2021 Hudson Molonglo Pty Ltd
