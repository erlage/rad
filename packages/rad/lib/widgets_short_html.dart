// ignore_for_file: directives_ordering
// ignore_for_file: camel_case_types

/// HTML widgets with short aliases.
///
library widgets_short_tags;

import 'package:rad/src/widgets/html/abbreviation.dart';
import 'package:rad/src/widgets/html/address.dart';
import 'package:rad/src/widgets/html/anchor.dart';
import 'package:rad/src/widgets/html/article.dart';
import 'package:rad/src/widgets/html/aside.dart';
import 'package:rad/src/widgets/html/audio.dart';
import 'package:rad/src/widgets/html/bidirectional_isolate.dart';
import 'package:rad/src/widgets/html/bidirectional_text_override.dart';
import 'package:rad/src/widgets/html/block_quote.dart';
import 'package:rad/src/widgets/html/button.dart';
import 'package:rad/src/widgets/html/canvas.dart';
import 'package:rad/src/widgets/html/citation.dart';
import 'package:rad/src/widgets/html/data.dart';
import 'package:rad/src/widgets/html/data_list.dart';
import 'package:rad/src/widgets/html/definition.dart';
import 'package:rad/src/widgets/html/deleted_text.dart';
import 'package:rad/src/widgets/html/description_details.dart';
import 'package:rad/src/widgets/html/description_list.dart';
import 'package:rad/src/widgets/html/description_term.dart';
import 'package:rad/src/widgets/html/details.dart';
import 'package:rad/src/widgets/html/dialog.dart';
import 'package:rad/src/widgets/html/division.dart';
import 'package:rad/src/widgets/html/embed_external.dart';
import 'package:rad/src/widgets/html/embed_text_track.dart';
import 'package:rad/src/widgets/html/emphasis.dart';
import 'package:rad/src/widgets/html/field_set.dart';
import 'package:rad/src/widgets/html/figure.dart';
import 'package:rad/src/widgets/html/figure_caption.dart';
import 'package:rad/src/widgets/html/footer.dart';
import 'package:rad/src/widgets/html/form.dart';
import 'package:rad/src/widgets/html/header.dart';
import 'package:rad/src/widgets/html/heading_1.dart';
import 'package:rad/src/widgets/html/heading_2.dart';
import 'package:rad/src/widgets/html/heading_3.dart';
import 'package:rad/src/widgets/html/heading_4.dart';
import 'package:rad/src/widgets/html/heading_5.dart';
import 'package:rad/src/widgets/html/heading_6.dart';
import 'package:rad/src/widgets/html/horizontal_rule.dart';
import 'package:rad/src/widgets/html/i_frame.dart';
import 'package:rad/src/widgets/html/idiomatic.dart';
import 'package:rad/src/widgets/html/image.dart';
import 'package:rad/src/widgets/html/image_map.dart';
import 'package:rad/src/widgets/html/image_map_area.dart';
import 'package:rad/src/widgets/html/inline_code.dart';
import 'package:rad/src/widgets/html/inline_quotation.dart';
import 'package:rad/src/widgets/html/input.dart';
import 'package:rad/src/widgets/html/inserted_text.dart';
import 'package:rad/src/widgets/html/keyboard_input.dart';
import 'package:rad/src/widgets/html/label.dart';
import 'package:rad/src/widgets/html/legend.dart';
import 'package:rad/src/widgets/html/line_break.dart';
import 'package:rad/src/widgets/html/line_break_opportunity.dart';
import 'package:rad/src/widgets/html/list_item.dart';
import 'package:rad/src/widgets/html/mark_text.dart';
import 'package:rad/src/widgets/html/media_source.dart';
import 'package:rad/src/widgets/html/menu.dart';
import 'package:rad/src/widgets/html/meter.dart';
import 'package:rad/src/widgets/html/navigation.dart';
import 'package:rad/src/widgets/html/option.dart';
import 'package:rad/src/widgets/html/option_group.dart';
import 'package:rad/src/widgets/html/ordered_list.dart';
import 'package:rad/src/widgets/html/output.dart';
import 'package:rad/src/widgets/html/paragraph.dart';
import 'package:rad/src/widgets/html/picture.dart';
import 'package:rad/src/widgets/html/portal.dart';
import 'package:rad/src/widgets/html/preformatted_text.dart';
import 'package:rad/src/widgets/html/progress.dart';
import 'package:rad/src/widgets/html/ruby_annotation.dart';
import 'package:rad/src/widgets/html/ruby_fallback_parenthesis.dart';
import 'package:rad/src/widgets/html/ruby_text.dart';
import 'package:rad/src/widgets/html/sample_output.dart';
import 'package:rad/src/widgets/html/select.dart';
import 'package:rad/src/widgets/html/small.dart';
import 'package:rad/src/widgets/html/span.dart';
import 'package:rad/src/widgets/html/strike_through.dart';
import 'package:rad/src/widgets/html/strong.dart';
import 'package:rad/src/widgets/html/sub_script.dart';
import 'package:rad/src/widgets/html/summary.dart';
import 'package:rad/src/widgets/html/super_script.dart';
import 'package:rad/src/widgets/html/table.dart';
import 'package:rad/src/widgets/html/table_body.dart';
import 'package:rad/src/widgets/html/table_caption.dart';
import 'package:rad/src/widgets/html/table_column.dart';
import 'package:rad/src/widgets/html/table_column_group.dart';
import 'package:rad/src/widgets/html/table_data_cell.dart';
import 'package:rad/src/widgets/html/table_foot.dart';
import 'package:rad/src/widgets/html/table_head.dart';
import 'package:rad/src/widgets/html/table_header_cell.dart';
import 'package:rad/src/widgets/html/table_row.dart';
import 'package:rad/src/widgets/html/text_area.dart';
import 'package:rad/src/widgets/html/time.dart';
import 'package:rad/src/widgets/html/un_ordered_list.dart';
import 'package:rad/src/widgets/html/variable.dart';
import 'package:rad/src/widgets/html/video.dart';

/// HTML's a tag([Anchor]).
///
typedef a = Anchor;

/// HTML's abbr tag([Abbreviation]).
///
typedef abbr = Abbreviation;

/// HTML's address tag([Address]).
///
typedef address = Address;

/// HTML's area tag([ImageMapArea]).
///
typedef area = ImageMapArea;

/// HTML's article tag([Article]).
///
typedef article = Article;

/// HTML's aside tag([Aside]).
///
typedef aside = Aside;

/// HTML's audio tag([Audio]).
///
typedef audio = Audio;

/// HTML's bdi tag([BidirectionalIsolate]).
///
typedef bdi = BidirectionalIsolate;

/// HTML's bdo tag([BidirectionalTextOverride]).
///
typedef bdo = BidirectionalTextOverride;

/// HTML's blockquote tag([BlockQuote]).
///
typedef blockquote = BlockQuote;

/// HTML's br tag([LineBreak]).
///
typedef br = LineBreak;

/// HTML's button tag([Button]).
///
typedef button = Button;

/// HTML's canvas tag([Canvas]).
///
typedef canvas = Canvas;

/// HTML's caption tag([TableCaption]).
///
typedef caption = TableCaption;

/// HTML's cite tag([Citation]).
///
typedef cite = Citation;

/// HTML's code tag([InlineCode]).
///
typedef code = InlineCode;

/// HTML's col tag([TableColumn]).
///
typedef col = TableColumn;

/// HTML's colgroup tag([TableColumnGroup]).
///
typedef colgroup = TableColumnGroup;

/// HTML's data tag([Data]).
///
typedef data = Data;

/// HTML's datalist tag([DataList]).
///
typedef datalist = DataList;

/// HTML's dd tag([DescriptionDetails]).
///
typedef dd = DescriptionDetails;

/// HTML's del tag([DeletedText]).
///
typedef del = DeletedText;

/// HTML's details tag([Details]).
///
typedef details = Details;

/// HTML's dfn tag([Definition]).
///
typedef dfn = Definition;

/// HTML's dialog tag([Dialog]).
///
typedef dialog = Dialog;

/// HTML's div tag([Division]).
///
typedef div = Division;

/// HTML's dl tag([DescriptionList]).
///
typedef dl = DescriptionList;

/// HTML's dt tag([DescriptionTerm]).
///
typedef dt = DescriptionTerm;

/// HTML's em tag([Emphasis]).
///
typedef em = Emphasis;

/// HTML's embed tag([EmbedExternal]).
///
typedef embed = EmbedExternal;

/// HTML's fieldset tag([FieldSet]).
///
typedef fieldset = FieldSet;

/// HTML's figcaption tag([FigureCaption]).
///
typedef figcaption = FigureCaption;

/// HTML's figure tag([Figure]).
///
typedef figure = Figure;

/// HTML's footer tag([Footer]).
///
typedef footer = Footer;

/// HTML's form tag([Form]).
///
typedef form = Form;

/// HTML's h1 tag([Heading1]).
///
typedef h1 = Heading1;

/// HTML's h2 tag([Heading2]).
///
typedef h2 = Heading2;

/// HTML's h3 tag([Heading3]).
///
typedef h3 = Heading3;

/// HTML's h4 tag([Heading4]).
///
typedef h4 = Heading4;

/// HTML's h5 tag([Heading5]).
///
typedef h5 = Heading5;

/// HTML's h6 tag([Heading6]).
///
typedef h6 = Heading6;

/// HTML's header tag([Header]).
///
typedef header = Header;

/// HTML's hr tag([HorizontalRule]).
///
typedef hr = HorizontalRule;

/// HTML's i tag([Idiomatic]).
///
typedef i = Idiomatic;

/// HTML's iframe tag([IFrame]).
///
typedef iframe = IFrame;

/// HTML's img tag([Image]).
///
typedef img = Image;

/// HTML's input tag([Input]).
///
typedef input = Input;

/// HTML's ins tag([InsertedText]).
///
typedef ins = InsertedText;

/// HTML's kbd tag([KeyboardInput]).
///
typedef kbd = KeyboardInput;

/// HTML's label tag([Label]).
///
typedef label = Label;

/// HTML's legend tag([Legend]).
///
typedef legend = Legend;

/// HTML's li tag([ListItem]).
///
typedef li = ListItem;

/// HTML's map tag([ImageMap]).
///
typedef map = ImageMap;

/// HTML's mark tag([MarkText]).
///
typedef mark = MarkText;

/// HTML's menu tag([Menu]).
///
typedef menu = Menu;

/// HTML's meter tag([Meter]).
///
typedef meter = Meter;

/// HTML's nav tag([Navigation]).
///
typedef nav = Navigation;

/// HTML's ol tag([OrderedList]).
///
typedef ol = OrderedList;

/// HTML's optgroup tag([OptionGroup]).
///
typedef optgroup = OptionGroup;

/// HTML's option tag([Option]).
///
typedef option = Option;

/// HTML's output tag([Output]).
///
typedef output = Output;

/// HTML's p tag([Paragraph]).
///
typedef p = Paragraph;

/// HTML's picture tag([Picture]).
///
typedef picture = Picture;

/// HTML's portal tag([Portal]).
///
typedef portal = Portal;

/// HTML's pre tag([PreformattedText]).
///
typedef pre = PreformattedText;

/// HTML's progress tag([Progress]).
///
typedef progress = Progress;

/// HTML's q tag([InlineQuotation]).
///
typedef q = InlineQuotation;

/// HTML's rp tag([RubyFallbackParenthesis]).
///
typedef rp = RubyFallbackParenthesis;

/// HTML's rt tag([RubyText]).
///
typedef rt = RubyText;

/// HTML's ruby tag([RubyAnnotation]).
///
typedef ruby = RubyAnnotation;

/// HTML's s tag([StrikeThrough]).
///
typedef s = StrikeThrough;

/// HTML's samp tag([SampleOutput]).
///
typedef samp = SampleOutput;

/// HTML's select tag([Select]).
///
typedef select = Select;

/// HTML's small tag([Small]).
///
typedef small = Small;

/// HTML's source tag([MediaSource]).
///
typedef source = MediaSource;

/// HTML's span tag([Span]).
///
typedef span = Span;

/// HTML's strong tag([Strong]).
///
typedef strong = Strong;

/// HTML's sub tag([SubScript]).
///
typedef sub = SubScript;

/// HTML's summary tag([Summary]).
///
typedef summary = Summary;

/// HTML's sup tag([SuperScript]).
///
typedef sup = SuperScript;

/// HTML's table tag([Table]).
///
typedef table = Table;

/// HTML's tbody tag([TableBody]).
///
typedef tbody = TableBody;

/// HTML's td tag([TableDataCell]).
///
typedef td = TableDataCell;

/// HTML's textarea tag([TextArea]).
///
typedef textarea = TextArea;

/// HTML's tfoot tag([TableFoot]).
///
typedef tfoot = TableFoot;

/// HTML's th tag([TableHeaderCell]).
///
typedef th = TableHeaderCell;

/// HTML's thead tag([TableHead]).
///
typedef thead = TableHead;

/// HTML's time tag([Time]).
///
typedef time = Time;

/// HTML's tr tag([TableRow]).
///
typedef tr = TableRow;

/// HTML's track tag([EmbedTextTrack]).
///
typedef track = EmbedTextTrack;

/// HTML's ul tag([UnOrderedList]).
///
typedef ul = UnOrderedList;

/// HTML's var tag([Variable]).
///
typedef vartag = Variable;

/// HTML's video tag([Video]).
///
typedef video = Video;

/// HTML's wbr tag([LineBreakOpportunity]).
///
typedef wbr = LineBreakOpportunity;
