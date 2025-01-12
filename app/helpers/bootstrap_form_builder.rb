class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  %w(text_field email_field password_field text_area file_field).each do |selector|
    class_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      def #{selector}(method, options = {})
        options.reverse_merge!(autocomplete: 'off')
        super(method, insert_class('form-control', options))
      end
    RUBY_EVAL
  end

  def label(method, content_or_options = nil, options = nil, &)
    super(method, content_or_options, insert_class('form-label', options), &)
  end

  def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
    super(method, insert_class('form-check-input', options), checked_value, unchecked_value)
  end

  private

  def insert_class(class_name, options)
    result = options ? options.dup : {}
    result[:class] = ((result[:class] || '') + " #{class_name}").strip
    result
  end
end
