class ArchivalObject
  def self.display_string_dates_config
    unless @display_string_dates_config
      @display_string_dates_config = if AppConfig.has_key?(:as_ao_display_string_dates)
                                       AppConfig[:as_ao_display_string_dates]
                                     else
                                       {}
                                     end
      @display_string_dates_config[:selector] ||= proc{|dates| dates.first}

      @display_string_dates_config[:builder] ||= proc{|date|
        [date['date_type'] == 'bulk' ? I18n.t("date_type_bulk.bulk") : nil,
         date['expression'] || [date['begin'], date['end']].compact.join(' - ')].compact.join(': ')
      }
    end

    @display_string_dates_config
  end


  def self.build_date_string(dates)
    ASUtils.wrap(display_string_dates_config[:selector].call(dates)).map{|d|
      display_string_dates_config[:builder].call(d)
    }.compact.join(', ')
  end


  def self.produce_display_string(json)
    [json['title'], build_date_string(json['dates'])].compact.select{|s| !s.empty?}.join(', ')
  end
end
