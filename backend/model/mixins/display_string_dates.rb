module DisplayStringDates

  def self.included(base)
    base.extend(ClassMethods)
  end


  module ClassMethods
    def sequel_to_jsonmodel(objs, opts = {})
      jsons = super

      jsons.zip(objs).each do |json, obj|
        # ignoring the stored display_string!
        json['display_string'] = [json['title'], build_date_string(json['dates'])].compact.select{|s| !s.empty?}.join(', ')
      end

      jsons
    end

    def build_date_string(dates)
      ASUtils.wrap(display_string_dates_config[:selector].call(dates)).map{|d|
        display_string_dates_config[:builder].call(d)
      }.compact.join(', ')

    end

    def display_string_dates_config
      unless @display_string_dates_config
        @display_string_dates_config = if AppConfig.has_key?(:as_ao_display_string_dates)
                                         AppConfig[:as_ao_display_string_dates]
                                       else
                                         {}
                                       end
        @display_string_dates_config[:selector] ||= proc{|dates| dates.first}
        @display_string_dates_config[:builder] ||= proc{|date| date['expression'] || [date['begin'], date['end']].compact.join(' - ')}
      end

      @display_string_dates_config
    end

  end

end
