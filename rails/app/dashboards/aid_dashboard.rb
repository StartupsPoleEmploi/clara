require "administrate/base_dashboard"

class AidDashboard < Administrate::BaseDashboard

  REMOVE_BUTTONS='Source,Save,NewPage,Preview,Print,Templates,Cut,Copy,Paste,PasteText,PasteFromWord,Undo,Redo,Find,Replace,SelectAll,Scayt,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,Italic,Strike,Subscript,Superscript,CopyFormatting,RemoveFormat,NumberedList,Outdent,Indent,Blockquote,CreateDiv,JustifyLeft,JustifyCenter,JustifyRight,JustifyBlock,BidiLtr,BidiRtl,Language,Unlink,Anchor,Image,Flash,Table,HorizontalRule,Smiley,PageBreak,Iframe,Styles,Format,Font,FontSize,TextColor,BGColor,Maximize,ShowBlocks,About,Bold,Underline,Link,SpecialChar,BulletedList'

  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number.with_options(export: false),
    name: Field::String,
    status: Field::String,
    zone_geo: Field::Text.with_options(truncate: 50000),
    source: Field::Text.with_options(export: false),
    ordre_affichage: Field::Number.with_options(export: false),
    archived_at: Field::DateTime,
    slug: Field::String.with_options(export: false),
    rule: Field::BelongsTo.with_options(export: false),
    contract_type: Field::BelongsTo,
    filters: Field::HasMany.with_options(export: false),
    short_description: Field::Text.with_options(export: false),
    what: Field::Ckeditor.with_options({ export: false, ckeditor: { removeButtons: REMOVE_BUTTONS }}),
    how_much: Field::Ckeditor.with_options({ export: false, ckeditor: { removeButtons: REMOVE_BUTTONS }}), 
    additionnal_conditions: Field::Ckeditor.with_options({ export: false, ckeditor: { removeButtons: REMOVE_BUTTONS }}),
    how_and_when: Field::Ckeditor.with_options({ export: false, ckeditor: { removeButtons: REMOVE_BUTTONS }}),
    limitations: Field::Ckeditor.with_options({ export: false, ckeditor: { removeButtons: REMOVE_BUTTONS }}),
    created_at: Field::DateTime.with_options(export: false),
    updated_at: AidLastUpdateField,

  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :name,
    :contract_type,
    :status,
    :updated_at,
    :archived_at,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :status,
    :source,
    :short_description,
    :filters,
    :ordre_affichage,
    :updated_at,
    :slug,
    :contract_type,
    :archived_at,
    :what,
    :how_much,
    :additionnal_conditions,
    :how_and_when,
    :limitations,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :name,
    :contract_type,
    :ordre_affichage,
    :rule,
    :source,
    :short_description,
    :filters,
    :archived_at,
    :what,
    :additionnal_conditions,
    :how_much,
    :how_and_when,
    :limitations,
  ].freeze

  # Overwrite this method to customize how aids are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(aid)
    aid.name
  end

end
