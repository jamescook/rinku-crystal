@[Link("rinku")]
lib LibRinku
  enum AutolinkMode
    AUTOLINK_URLS   = 1 << 0
    AUTOLINK_EMAILS = 1 << 1
    AUTOLINK_ALL    = AUTOLINK_URLS | AUTOLINK_EMAILS
  end

  struct Buffer
    data : LibC::Char*
    size : LibC::SizeT
    asize : LibC::SizeT
    unit : LibC::SizeT
  end

  fun bufnew(LibC::SizeT) : Buffer*
  fun bufput(Buffer*, Void*, LibC::SizeT) : Void
  fun bufrelease(Buffer*) : Void

  # Callback to replace the text within the link, e.g. <a href="...">callback output goes here</a>
  alias Callback = (Buffer*, LibC::Char*, LibC::SizeT, Void*) ->

  fun autolink = rinku_autolink(
    ob : Buffer*,
    text : LibC::Char*,
    size : LibC::SizeT,
    mode : AutolinkMode,
    flags : LibC::UInt,
    link_attr : LibC::Char*,
    skip_tags : LibC::Char**,
    callback : Callback,
    payload : Void*
  ) : LibC::Int
end
