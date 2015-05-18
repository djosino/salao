module Paperclip
  module Validators
    class AttachmentSizeValidator < ActiveModel::Validations::NumericalityValidator
      def validate_each(record, attr_name, value)
        base_attr_name = attr_name
        attr_name = "#{attr_name}_file_size".to_sym
        value = record.send(:read_attribute_for_validation, attr_name).try(:to_i)

        unless value.blank?
          options.slice(*AVAILABLE_CHECKS).each do |option, option_value|
            option_value = option_value.call(record) if option_value.is_a?(Proc)
            option_value = extract_option_value(option, option_value)

            unless value.send(CHECKS[option], option_value)
              error_message_key = options[:in] ? :in_between : option
              [ attr_name, base_attr_name ].each do |error_attr_name|
                record.errors.add(error_attr_name, error_message_key, filtered_options(value).merge(
                  :min => min_value_in_human_size(record),
                  :max => max_value_in_human_size(record),
                  :count => human_size(option_value)
                ))
              end
            end
          end
        end
      end
    end
  end
end
