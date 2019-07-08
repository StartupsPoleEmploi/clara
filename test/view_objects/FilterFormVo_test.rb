require "test_helper"

class FilterFormVoTest < ActiveSupport::TestCase
  

  test ".attr_name returns attribute name, simple example" do
    #given
    sut = FilterFormVo.new(nil, {page: nominal_page})
    #when
    res = sut.attr_name(name_attr)
    #then
    assert_equal("name", res)
  end

  test ".attr_name returns attribute name, other simple example" do
    #given
    sut = FilterFormVo.new(nil, {page: nominal_page})
    #when
    res = sut.attr_name(ordre_affichage_attr)
    #then
    assert_equal("ordre_affichage", res)
  end

  test "._init_errors_messages returns empty hash if no errors in page" do
    #given
    sut = FilterFormVo.new(nil, {page: nominal_page})
    #when
    res = sut._init_errors_messages
    #then
    assert_equal({}, res)
  end

  test "._init_errors_messages returns errors messages" do
    #given
    sut = FilterFormVo.new(nil, {page: errored_page})
    #when
    res = sut._init_errors_messages
    #then
    assert_equal({:name=>["doit être renseigné(e)"], :description=>["doit être renseigné(e)"]}, res)
  end

  test ".mandatory? returns true if field is mandatory" do
    #given
    sut = FilterFormVo.new(nil, {page: nominal_page})
    #when
    res = sut.mandatory?(name_attr)
    #then
    assert_equal(true, res)
  end

  def nominal_page
    Marshal.load(serialized_nominal_page_object)
  end

  def ordre_affichage_attr
    Marshal.load(serialized_ordre_affichage_attribute)
  end

  def name_attr
    Marshal.load(serialized_name_attribute)
  end

  def errored_page
    Marshal.load("\x04\bo:\x1DAdministrate::Page::Form\t:\x0F@dashboardo:\x14FilterDashboard\x00:\r@options{\x00:\x0E@resourceo:\vFilter\x13:\x10@attributeso:\x1EActiveModel::AttributeSet\x06;\v{\fI\"\aid\x06:\x06ETo:)ActiveModel::Attribute::FromDatabase\n:\n@name@\v:\x1C@value_before_type_cast0:\n@typeo:\x1FActiveModel::Type::Integer\t:\x0F@precision0:\v@scale0:\v@limiti\r:\v@rangeo:\nRange\b:\texclT:\nbeginl-\t\x00\x00\x00\x00\x00\x00\x00\x80:\bendl+\t\x00\x00\x00\x00\x00\x00\x00\x80:\x18@original_attribute0:\v@value0I\"\tname\x06;\rTo:%ActiveModel::Attribute::FromUser\n;\x0F@\x11;\x10I\"\x00\x06;\rT;\x11o:\x1DActiveRecord::Type::Text\b;\x130;\x140;\x150;\eo;\x0E\t;\x0F@\x11;\x100;\x11@\x14;\e0;\x1CI\"\x00\x06;\rTI\"\x0Fcreated_at\x06;\rTo;\x0E\n;\x0F@\x17;\x100;\x11U:JActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter[\t:\v__v2__[\x00[\x00o:@ActiveRecord::ConnectionAdapters::PostgreSQL::OID::DateTime\b;\x130;\x140;\x150;\e0;\x1C0I\"\x0Fupdated_at\x06;\rTo;\x0E\n;\x0F@\x1E;\x100;\x11U;\x1F[\t; [\x00[\x00@\x1D;\e0;\x1C0I\"\x10description\x06;\rTo;\x1D\n;\x0F@$;\x10I\"\x00\x06;\rT;\x11o:\x1EActiveModel::Type::String\b;\x130;\x140;\x150;\eo;\x0E\t;\x0F@$;\x100;\x11@';\e0;\x1CI\"\x00\x06;\rTI\"\tslug\x06;\rTo;\x1D\n;\x0F@*;\x10I\")9714e0ba-278e-4ad9-8887-627922a87976\x06;\rF;\x11@';\eo;\x0E\n;\x0F@*;\x100;\x11@';\e0;\x1C0;\x1CI\")9714e0ba-278e-4ad9-8887-627922a87976\x06;\rFI\"\x14ordre_affichage\x06;\rTo;\x1D\n;\x0F@/;\x10I\"\x00\x06;\rT;\x11o;\x12\t;\x130;\x140;\x15i\t;\x16o;\x17\b;\x18T;\x19l-\a\x00\x00\x00\x80;\x1Al+\a\x00\x00\x00\x80;\eo;\x0E\t;\x0F@/;\x100;\x11@2;\e0;\x1C0:\x17@aggregation_cache{\x00:\x17@association_cache{\x06:\taidsU::ActiveRecord::Associations::HasManyThroughAssociation[\a;%[\r[\a:\v@owner@\b[\a:\f@loadedT[\a:\f@target[\x00[\a:\x11@stale_state0[\a:\x0E@inversedF[\a:\x15@association_ids0[\a:\x17@association_scope0[\a:\x15@through_records{\x00:\x0E@readonlyF:\x0F@destroyedF:\x1C@marked_for_destructionF:\x1E@destroyed_by_association0:\x10@new_recordT:\x1E@_start_transaction_state{\n:\aid0:\x0Fnew_recordT:\x0EdestroyedF:\ffrozen?F:\nleveli\x06:\x17@transaction_stateo:7ActiveRecord::ConnectionAdapters::TransactionState\a:\v@state:\x15fully_rolledback:\x0E@children[\x00:$@_new_record_before_last_commitT:\x18@validation_context0:\f@errorsU:\x18ActiveModel::Errors[\b@\b{\a:\tname[\x06I\"\x1Ddoit \xC3\xAAtre renseign\xC3\xA9(e)\x06;\rT:\x10description[\x06I\"\x1Ddoit \xC3\xAAtre renseign\xC3\xA9(e)\x06;\rT{\a;C[\x06{\x06:\nerror:\nblank;D[\x06{\x06;E;F:\x15@_already_called{\a:1validate_associated_records_for_filters_aidsF:)validate_associated_records_for_aidsF:\x13@resource_nameI\"\vfilter\x06;\rF")
  end

  def serialized_nominal_page_object
    "\x04\bo:\x1DAdministrate::Page::Form\t:\x0F@dashboardo:\x14FilterDashboard\x00:\r@options{\x00:\x0E@resourceo:\vFilter\x10:\x10@attributeso:\x1EActiveModel::AttributeSet\x06;\v{\fI\"\aid\x06:\x06ETo:)ActiveModel::Attribute::FromDatabase\n:\n@name@\v:\x1C@value_before_type_cast0:\n@typeo:\x1FActiveModel::Type::Integer\t:\x0F@precision0:\v@scale0:\v@limiti\r:\v@rangeo:\nRange\b:\texclT:\nbeginl-\t\x00\x00\x00\x00\x00\x00\x00\x80:\bendl+\t\x00\x00\x00\x00\x00\x00\x00\x80:\x18@original_attribute0:\v@value0I\"\tname\x06;\rTo;\x0E\n;\x0F@\x11;\x100;\x11o:\x1DActiveRecord::Type::Text\b;\x130;\x140;\x150;\e0;\x1C0I\"\x0Fcreated_at\x06;\rTo;\x0E\n;\x0F@\x14;\x100;\x11U:JActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter[\t:\v__v2__[\x00[\x00o:@ActiveRecord::ConnectionAdapters::PostgreSQL::OID::DateTime\b;\x130;\x140;\x150;\e0;\x1C0I\"\x0Fupdated_at\x06;\rTo;\x0E\n;\x0F@\e;\x100;\x11U;\x1E[\t;\x1F[\x00[\x00@\x1A;\e0;\x1C0I\"\x10description\x06;\rTo;\x0E\n;\x0F@!;\x100;\x11o:\x1EActiveModel::Type::String\b;\x130;\x140;\x150;\e0;\x1C0I\"\tslug\x06;\rTo;\x0E\n;\x0F@$;\x100;\x11@#;\e0;\x1C0I\"\x14ordre_affichage\x06;\rTo;\x0E\n;\x0F@&;\x100;\x11o;\x12\t;\x130;\x140;\x15i\t;\x16o;\x17\b;\x18T;\x19l-\a\x00\x00\x00\x80;\x1Al+\a\x00\x00\x00\x80;\e0;\x1C0:\x17@aggregation_cache{\x00:\x17@association_cache{\x00:\x0E@readonlyF:\x0F@destroyedF:\x1C@marked_for_destructionF:\x1E@destroyed_by_association0:\x10@new_recordT:\x1E@_start_transaction_state{\x00:\x17@transaction_state0:\f@errorsU:\x18ActiveModel::Errors[\b@\b{\x00{\x00:\x13@resource_nameI\"\vfilter\x06;\rF"
  end

  def serialized_ordre_affichage_attribute
    "\x04\bo: Administrate::Field::Number\n:\x0F@attribute:\x14ordre_affichage:\n@data0:\n@page:\tform:\x0E@resourceo:\vFilter\x10:\x10@attributeso:\x1EActiveModel::AttributeSet\x06;\r{\fI\"\aid\x06:\x06ETo:)ActiveModel::Attribute::FromDatabase\n:\n@name@\t:\x1C@value_before_type_cast0:\n@typeo:\x1FActiveModel::Type::Integer\t:\x0F@precision0:\v@scale0:\v@limiti\r:\v@rangeo:\nRange\b:\texclT:\nbeginl-\t\x00\x00\x00\x00\x00\x00\x00\x80:\bendl+\t\x00\x00\x00\x00\x00\x00\x00\x80:\x18@original_attribute0:\v@value0I\"\tname\x06;\x0FTo;\x10\n;\x11@\x0F;\x120;\x13o:\x1DActiveRecord::Type::Text\b;\x150;\x160;\x170;\x1D0;\x1E0I\"\x0Fcreated_at\x06;\x0FTo;\x10\n;\x11@\x12;\x120;\x13U:JActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter[\t:\v__v2__[\x00[\x00o:@ActiveRecord::ConnectionAdapters::PostgreSQL::OID::DateTime\b;\x150;\x160;\x170;\x1D0;\x1E0I\"\x0Fupdated_at\x06;\x0FTo;\x10\n;\x11@\x19;\x120;\x13U; [\t;![\x00[\x00@\x18;\x1D0;\x1E0I\"\x10description\x06;\x0FTo;\x10\n;\x11@\x1F;\x120;\x13o:\x1EActiveModel::Type::String\b;\x150;\x160;\x170;\x1D0;\x1E0I\"\tslug\x06;\x0FTo;\x10\n;\x11@\";\x120;\x13@!;\x1D0;\x1E0I\"\x14ordre_affichage\x06;\x0FTo;\x10\n;\x11@$;\x120;\x13o;\x14\t;\x150;\x160;\x17i\t;\x18o;\x19\b;\x1AT;\el-\a\x00\x00\x00\x80;\x1Cl+\a\x00\x00\x00\x80;\x1D0;\x1E0:\x17@aggregation_cache{\x00:\x17@association_cache{\x06:\taidsU::ActiveRecord::Associations::HasManyThroughAssociation[\a;&[\x0E[\a:\v@owner@\x06[\a:\f@loadedF[\a:\f@target[\x00[\a:\x11@stale_state0[\a:\x0E@inversedF[\a:\x15@association_ids0[\a:\x17@association_scopeo:\x1FAid::ActiveRecord_Relation\x0E:\v@klassc\bAid:\v@tableo:\x10Arel::Table\b;\x11I\"\taids\x06;\x0FT:\x11@type_castero:\"ActiveRecord::TypeCaster::Map\x06:\v@types@8:\x11@table_alias0:\f@values{\t:\x0Eextending[\x00:\x0Freferences[\x06I\"\x11aids_filters\x06;\x0FT:\nwhereo:(ActiveRecord::Relation::WhereClause\x06:\x10@predicates[\x06o:\x1AArel::Nodes::Equality\a:\n@leftS: Arel::Attributes::Attribute\a:\rrelationo:\x1CArel::Nodes::TableAlias\a;>o;2\b;\x11I\"\x11aids_filters\x06;\x0FT;3o;4\x06;5c\x17Aid::HABTM_Filters;60:\v@right@?:\tnameI\"\x0Efilter_id\x06;\x0FF;Bo:\eArel::Nodes::BindParam\x06;\x1Eo:+ActiveRecord::Relation::QueryAttribute\t;\x11@I;\x120;\x13@\v;\x1D0:\njoins[\x06o:\eArel::Nodes::InnerJoin\a;>o;2\b;\x11I\"\x11aids_filters\x06;\x0FT;3o;4\x06;5c\x17Filter::HABTM_Aids;60;Bo:\x14Arel::Nodes::On\x06:\n@expro;=\a;>S;?\a;@o;2\b;\x11@:;3o;4\x06;5@8;60;CI\"\aid\x06;\x0FT;BS;?\a;@@N;CI\"\vaid_id\x06;\x0FT:\r@offsets{\x00;)F:\x17@predicate_buildero:#ActiveRecord::PredicateBuilder\a;1o: ActiveRecord::TableMetadata\b;0@8:\x10@arel_table@9:\x11@association0:\x0E@handlers[\v[\ac\bSeto:1ActiveRecord::PredicateBuilder::ArrayHandler\x06;K@[[\ac\nArrayo;Q\x06;K@[[\ac\eActiveRecord::Relationo:4ActiveRecord::PredicateBuilder::RelationHandler\x00[\ac\nRangeo:1ActiveRecord::PredicateBuilder::RangeHandler\x06;K@[[\ac\x17ActiveRecord::Baseo:0ActiveRecord::PredicateBuilder::BaseHandler\x06;K@[[\ac\x10BasicObjecto:7ActiveRecord::PredicateBuilder::BasicObjectHandler\x06;K@[:\x17@delegate_to_klassF:\x1A@where_clause_factoryo:/ActiveRecord::Relation::WhereClauseFactory\a;0@8;K@[:\n@arelo:\x18Arel::SelectManager\a:\t@ctxo:\x1CArel::Nodes::SelectCore\r:\f@sourceo:\x1CArel::Nodes::JoinSource\a;>@9;B[\x06@M:\t@top0:\x14@set_quantifier0:\x11@projections[\x06S;?\a;@@9;CIC:\x1CArel::Nodes::SqlLiteral\"\x06*\x06;\x0FT:\f@wheres[\x06o:\x15Arel::Nodes::And\x06:\x0E@children[\x06@B:\f@groups[\x00:\r@havings[\x00:\r@windows[\x00:\t@asto:!Arel::Nodes::SelectStatement\v:\v@cores[\x06@r:\f@orders[\x00;\x170:\n@lock0:\f@offset0:\n@with0[\a:\x15@through_records{\x00[\a:\v@proxyo:3Aid::ActiveRecord_Associations_CollectionProxy\x0E;O@,;0@8;1@9;7{\x00;J{\x00;)F;K@[;VF:\v@scopee:\x1FActiveRecord::NullRelationo:*Aid::ActiveRecord_AssociationRelation\x0F;0@8;1@9;7{\t;9[\x06@?;:o;;\x06;<[\a@BI\"\b1=0\x06;\x0FT;F[\x06@M;8[\x06m\x1FActiveRecord::NullRelation;J{\x00;)F;K@[;VF;O@,;Wo;X\a;0@8;K@[;Yo;Z\a;[o;\\\r;]o;^\a;>@9;B[\x06@M;_0;`0;a[\x06S;?\a;@@9;CIC;b\"\x06*\x06;\x0FT;c[\x06o;d\x06;e[\a@Bo:\x1AArel::Nodes::Grouping\x06;IIC;b\"\b1=0\x06;\x0FT;f[\x00;g[\x00;h[\x00;io;j\v;k[\x06@\x01\x8E;l[\x00;\x170;m0;n0;o0:\x0E@readonlyF:\x0F@destroyedF:\x1C@marked_for_destructionF:\x1E@destroyed_by_association0:\x10@new_recordT:\x1E@_start_transaction_state{\x00:\x17@transaction_state0:\f@errorsU:\x18ActiveModel::Errors[\b@\x06{\a:\bNom[\x00;C[\x00{\x00:\r@options{\x00"
  end

  def serialized_name_attribute
    "\x04\bo: Administrate::Field::String\n:\x0F@attribute:\tname:\n@data0:\n@page:\tform:\x0E@resourceo:\vFilter\x10:\x10@attributeso:\x1EActiveModel::AttributeSet\x06;\r{\fI\"\aid\x06:\x06ETo:)ActiveModel::Attribute::FromDatabase\n:\n@name@\t:\x1C@value_before_type_cast0:\n@typeo:\x1FActiveModel::Type::Integer\t:\x0F@precision0:\v@scale0:\v@limiti\r:\v@rangeo:\nRange\b:\texclT:\nbeginl-\t\x00\x00\x00\x00\x00\x00\x00\x80:\bendl+\t\x00\x00\x00\x00\x00\x00\x00\x80:\x18@original_attribute0:\v@value0I\"\tname\x06;\x0FTo;\x10\n;\x11@\x0F;\x120;\x13o:\x1DActiveRecord::Type::Text\b;\x150;\x160;\x170;\x1D0;\x1E0I\"\x0Fcreated_at\x06;\x0FTo;\x10\n;\x11@\x12;\x120;\x13U:JActiveRecord::AttributeMethods::TimeZoneConversion::TimeZoneConverter[\t:\v__v2__[\x00[\x00o:@ActiveRecord::ConnectionAdapters::PostgreSQL::OID::DateTime\b;\x150;\x160;\x170;\x1D0;\x1E0I\"\x0Fupdated_at\x06;\x0FTo;\x10\n;\x11@\x19;\x120;\x13U; [\t;![\x00[\x00@\x18;\x1D0;\x1E0I\"\x10description\x06;\x0FTo;\x10\n;\x11@\x1F;\x120;\x13o:\x1EActiveModel::Type::String\b;\x150;\x160;\x170;\x1D0;\x1E0I\"\tslug\x06;\x0FTo;\x10\n;\x11@\";\x120;\x13@!;\x1D0;\x1E0I\"\x14ordre_affichage\x06;\x0FTo;\x10\n;\x11@$;\x120;\x13o;\x14\t;\x150;\x160;\x17i\t;\x18o;\x19\b;\x1AT;\el-\a\x00\x00\x00\x80;\x1Cl+\a\x00\x00\x00\x80;\x1D0;\x1E0:\x17@aggregation_cache{\x00:\x17@association_cache{\x06:\taidsU::ActiveRecord::Associations::HasManyThroughAssociation[\a;&[\x0E[\a:\v@owner@\x06[\a:\f@loadedF[\a:\f@target[\x00[\a:\x11@stale_state0[\a:\x0E@inversedF[\a:\x15@association_ids0[\a:\x17@association_scope0[\a:\x15@through_records{\x00[\a:\v@proxyo:3Aid::ActiveRecord_Associations_CollectionProxy\x0E:\x11@association@,:\v@klassc\bAid:\v@tableo:\x10Arel::Table\b;\x11I\"\taids\x06;\x0FT:\x11@type_castero:\"ActiveRecord::TypeCaster::Map\x06:\v@types@;:\x11@table_alias0:\f@values{\x00:\r@offsets{\x00;)F:\x17@predicate_buildero:#ActiveRecord::PredicateBuilder\a;4o: ActiveRecord::TableMetadata\b;3@;:\x10@arel_table@<;20:\x0E@handlers[\v[\ac\bSeto:1ActiveRecord::PredicateBuilder::ArrayHandler\x06;<@A[\ac\nArrayo;A\x06;<@A[\ac\eActiveRecord::Relationo:4ActiveRecord::PredicateBuilder::RelationHandler\x00[\ac\nRangeo:1ActiveRecord::PredicateBuilder::RangeHandler\x06;<@A[\ac\x17ActiveRecord::Baseo:0ActiveRecord::PredicateBuilder::BaseHandler\x06;<@A[\ac\x10BasicObjecto:7ActiveRecord::PredicateBuilder::BasicObjectHandler\x06;<@A:\x17@delegate_to_klassF:\v@scopee:\x1FActiveRecord::NullRelationo:*Aid::ActiveRecord_AssociationRelation\x0F;3@;;4@<;:{\t:\x0Freferences[\x06I\"\x11aids_filters\x06;\x0FT:\nwhereo:(ActiveRecord::Relation::WhereClause\x06:\x10@predicates[\ao:\x1AArel::Nodes::Equality\a:\n@leftS: Arel::Attributes::Attribute\a:\rrelationo:\x1CArel::Nodes::TableAlias\a;Oo;5\b;\x11I\"\x11aids_filters\x06;\x0FT;6o;7\x06;8c\x17Aid::HABTM_Filters;90:\v@right@Y;\aI\"\x0Efilter_id\x06;\x0FF;So:\eArel::Nodes::BindParam\x06;\x1Eo:+ActiveRecord::Relation::QueryAttribute\t;\x11@c;\x120;\x13@\v;\x1D0I\"\b1=0\x06;\x0FT:\njoins[\x06o:\eArel::Nodes::InnerJoin\a;Oo;5\b;\x11I\"\x11aids_filters\x06;\x0FT;6o;7\x06;8c\x17Filter::HABTM_Aids;90;So:\x14Arel::Nodes::On\x06:\n@expro;N\a;OS;P\a;Qo;5\b;\x11@=;6o;7\x06;8@;;90;\aI\"\aid\x06;\x0FT;SS;P\a;Q@i;\aI\"\vaid_id\x06;\x0FT:\x0Eextending[\x06m\x1FActiveRecord::NullRelation;;{\x00;)F;<@A;FF;2@,:\x1A@where_clause_factoryo:/ActiveRecord::Relation::WhereClauseFactory\a;3@;;<@A:\n@arelo:\x18Arel::SelectManager\a:\t@ctxo:\x1CArel::Nodes::SelectCore\r:\f@sourceo:\x1CArel::Nodes::JoinSource\a;O@<;S[\x06@h:\t@top0:\x14@set_quantifier0:\x11@projections[\x06S;P\a;Q@<;\aIC:\x1CArel::Nodes::SqlLiteral\"\x06*\x06;\x0FT:\f@wheres[\x06o:\x15Arel::Nodes::And\x06:\x0E@children[\a@\\o:\x1AArel::Nodes::Grouping\x06;YIC;f\"\b1=0\x06;\x0FT:\f@groups[\x00:\r@havings[\x00:\r@windows[\x00:\t@asto:!Arel::Nodes::SelectStatement\v:\v@cores[\x06@z:\f@orders[\x00;\x170:\n@lock0:\f@offset0:\n@with0:\x0E@readonlyF:\x0F@destroyedF:\x1C@marked_for_destructionF:\x1E@destroyed_by_association0:\x10@new_recordT:\x1E@_start_transaction_state{\x00:\x17@transaction_state0:\f@errorsU:\x18ActiveModel::Errors[\b@\x06{\x00{\x00:\r@options{\x00"
  end


end
