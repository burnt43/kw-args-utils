module Kernel
  def kw_args_as_options(caller_binding)
    caller_method_name = caller[0].split[-1].gsub(/[`']/, '').split('#')[-1].to_sym

    method(caller_method_name).parameters.each_with_object({}) do |type_name_pair, hash|
      type, name = type_name_pair
      next unless type == :key || :keyreq

      hash[name] = caller_binding.local_variable_get(name)
    end
  end
end
