require "./librinku"

module Rinku
  VERSION = "0.1.0"

  DEFAULT_SKIP_TAGS = ["a", "pre", "code", "kbd", "script"]

  DEFAULT_CALLBACK = ->(buf : LibRinku::Buffer*, link : LibC::Char*, link_len : LibC::SizeT, payload : Void*) do
    LibRinku.bufput(buf, link, link_len)
  end

  BUFFER_SIZE = 32

  def self.auto_link(text     : String,
                    mode      : Symbol|Nil = :all,
                    link_attr : String|Nil = nil,
                    skip_tags : Array = DEFAULT_SKIP_TAGS,
                    callback  : Nil|Proc = DEFAULT_CALLBACK)
                    
    autolink_mode = case mode
                    when :all
                      LibRinku::AutolinkMode::AUTOLINK_ALL
                    when :urls
                      LibRinku::AutolinkMode::AUTOLINK_URLS
                    when :email
                      LibRinku::AutolinkMode::AUTOLINK_EMAILS
                    else
                      LibRinku::AutolinkMode::AUTOLINK_ALL
                    end

    rinku_autolink(text, autolink_mode, link_attr, skip_tags, callback)
  end

  private def self.rinku_autolink(text           : String,
                                  mode           : LibRinku::AutolinkMode,
                                  link_attr      : String|Nil,
                                  skip_tags      : Array,
                                  cback_function : Proc|Pointer)
    buf = LibRinku.bufnew(BUFFER_SIZE)

    p_link_attr = if link_attr
      link_attr.to_unsafe
    else
      Pointer(LibC::Char).null
    end

    p_skip_tags = if skip_tags.size > 0
      skip_tags.map{|t| t.to_unsafe }.to_unsafe
    else
      DEFAULT_SKIP_TAGS.map{|t| t.to_unsafe }.to_unsafe
    end

    autolink_result = LibRinku.autolink(
      buf,
      text.to_unsafe,
      text.bytesize, 
      mode,
      0, # flags - for short domains, see Rinku source
      p_link_attr, # link_attr
      p_skip_tags, # skip_tags
      cback_function, # callback function
      nil    # payload for a custom callback ???
    )

    # No links found, return original string
    if autolink_result == 0
      LibRinku.bufrelease(buf)
      return text
    end

    output = String.new(buf[0].data, buf[0].size)
    LibRinku.bufrelease(buf)
    output
  end
end
