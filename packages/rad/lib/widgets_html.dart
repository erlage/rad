// ignore_for_file: directives_ordering

/// HTML widgets.
///
library widgets_html;

// base for all HTML widgets
export 'src/widgets/abstract/html_widget_base.dart' show HTMLWidgetBase;

export 'src/widgets/html/abbreviation.dart' show Abbreviation;
export 'src/widgets/html/address.dart' show Address;
export 'src/widgets/html/anchor.dart' show Anchor;
export 'src/widgets/html/article.dart' show Article;
export 'src/widgets/html/aside.dart' show Aside;
export 'src/widgets/html/audio.dart' show Audio;
export 'src/widgets/html/bidirectional_isolate.dart' show BidirectionalIsolate;
export 'src/widgets/html/bidirectional_text_override.dart'
    show BidirectionalTextOverride;
export 'src/widgets/html/block_quote.dart' show BlockQuote;
export 'src/widgets/html/button.dart' show Button;
export 'src/widgets/html/canvas.dart' show Canvas;
export 'src/widgets/html/table_caption.dart' show TableCaption;
export 'src/widgets/html/citation.dart' show Citation;
export 'src/widgets/html/inline_code.dart' show InlineCode;
export 'src/widgets/html/data_list.dart' show DataList;
export 'src/widgets/html/data.dart' show Data;
export 'src/widgets/html/definition.dart' show Definition;
export 'src/widgets/html/deleted_text.dart' show DeletedText;
export 'src/widgets/html/description_details.dart' show DescriptionDetails;
export 'src/widgets/html/description_list.dart' show DescriptionList;
export 'src/widgets/html/description_term.dart' show DescriptionTerm;
export 'src/widgets/html/details.dart' show Details;
export 'src/widgets/html/dialog.dart' show Dialog;
export 'src/widgets/html/division.dart' show Division;
export 'src/widgets/html/embed_external.dart' show EmbedExternal;
export 'src/widgets/html/embed_text_track.dart' show EmbedTextTrack;
export 'src/widgets/html/emphasis.dart' show Emphasis;
export 'src/widgets/html/field_set.dart' show FieldSet;
export 'src/widgets/html/figure_caption.dart' show FigureCaption;
export 'src/widgets/html/figure.dart' show Figure;
export 'src/widgets/html/footer.dart' show Footer;
export 'src/widgets/html/form.dart' show Form;
export 'src/widgets/html/header.dart' show Header;
export 'src/widgets/html/heading_1.dart' show Heading1;
export 'src/widgets/html/heading_2.dart' show Heading2;
export 'src/widgets/html/heading_3.dart' show Heading3;
export 'src/widgets/html/heading_4.dart' show Heading4;
export 'src/widgets/html/heading_5.dart' show Heading5;
export 'src/widgets/html/heading_6.dart' show Heading6;
export 'src/widgets/html/horizontal_rule.dart' show HorizontalRule;
export 'src/widgets/html/idiomatic.dart' show Idiomatic;
export 'src/widgets/html/i_frame.dart' show IFrame;
export 'src/widgets/html/image_map_area.dart' show ImageMapArea;
export 'src/widgets/html/image_map.dart' show ImageMap;
export 'src/widgets/html/image.dart' show Image;
export 'src/widgets/html/inline_quotation.dart' show InlineQuotation;
export 'src/widgets/html/input.dart' show Input;
export 'src/widgets/html/inserted_text.dart' show InsertedText;
export 'src/widgets/html/keyboard_input.dart' show KeyboardInput;
export 'src/widgets/html/label.dart' show Label;
export 'src/widgets/html/legend.dart' show Legend;
export 'src/widgets/html/line_break_opportunity.dart' show LineBreakOpportunity;
export 'src/widgets/html/line_break.dart' show LineBreak;
export 'src/widgets/html/list_item.dart' show ListItem;
export 'src/widgets/html/mark_text.dart' show MarkText;
export 'src/widgets/html/media_source.dart' show MediaSource;
export 'src/widgets/html/menu.dart' show Menu;
export 'src/widgets/html/meter.dart' show Meter;
export 'src/widgets/html/navigation.dart' show Navigation;
export 'src/widgets/html/option_group.dart' show OptionGroup;
export 'src/widgets/html/option.dart' show Option;
export 'src/widgets/html/ordered_list.dart' show OrderedList;
export 'src/widgets/html/output.dart' show Output;
export 'src/widgets/html/paragraph.dart' show Paragraph;
export 'src/widgets/html/picture.dart' show Picture;
export 'src/widgets/html/portal.dart' show Portal;
export 'src/widgets/html/preformatted_text.dart' show PreformattedText;
export 'src/widgets/html/progress.dart' show Progress;
export 'src/widgets/html/ruby_annotation.dart' show RubyAnnotation;
export 'src/widgets/html/ruby_fallback_parenthesis.dart'
    show RubyFallbackParenthesis;
export 'src/widgets/html/ruby_text.dart' show RubyText;
export 'src/widgets/html/sample_output.dart' show SampleOutput;
export 'src/widgets/html/section.dart' show Section;
export 'src/widgets/html/select.dart' show Select;
export 'src/widgets/html/small.dart' show Small;
export 'src/widgets/html/span.dart' show Span;
export 'src/widgets/html/strike_through.dart' show StrikeThrough;
export 'src/widgets/html/strong.dart' show Strong;
export 'src/widgets/html/sub_script.dart' show SubScript;
export 'src/widgets/html/summary.dart' show Summary;
export 'src/widgets/html/super_script.dart' show SuperScript;
export 'src/widgets/html/table_body.dart' show TableBody;
export 'src/widgets/html/table_column_group.dart' show TableColumnGroup;
export 'src/widgets/html/table_column.dart' show TableColumn;
export 'src/widgets/html/table_data_cell.dart' show TableDataCell;
export 'src/widgets/html/table_foot.dart' show TableFoot;
export 'src/widgets/html/table_head.dart' show TableHead;
export 'src/widgets/html/table_header_cell.dart' show TableHeaderCell;
export 'src/widgets/html/table_row.dart' show TableRow;
export 'src/widgets/html/table.dart' show Table;
export 'src/widgets/html/text_area.dart' show TextArea;
export 'src/widgets/html/time.dart' show Time;
export 'src/widgets/html/un_ordered_list.dart' show UnOrderedList;
export 'src/widgets/html/variable.dart' show Variable;
export 'src/widgets/html/video.dart' show Video;

// Additional widgets.

export 'src/widgets/additional/input_button.dart' show InputButton;
export 'src/widgets/additional/input_checkbox.dart' show InputCheckBox;
export 'src/widgets/additional/input_color.dart' show InputColor;
export 'src/widgets/additional/input_date_time_local.dart'
    show InputDateTimeLocal;
export 'src/widgets/additional/input_date.dart' show InputDate;
export 'src/widgets/additional/input_email.dart' show InputEmail;
export 'src/widgets/additional/input_file.dart' show InputFile;
export 'src/widgets/additional/input_hidden.dart' show InputHidden;
export 'src/widgets/additional/input_image.dart' show InputImage;
export 'src/widgets/additional/input_month.dart' show InputMonth;
export 'src/widgets/additional/input_number.dart' show InputNumber;
export 'src/widgets/additional/input_password.dart' show InputPassword;
export 'src/widgets/additional/input_radio.dart' show InputRadio;
export 'src/widgets/additional/input_range.dart' show InputRange;
export 'src/widgets/additional/input_reset.dart' show InputReset;
export 'src/widgets/additional/input_search.dart' show InputSearch;
export 'src/widgets/additional/input_submit.dart' show InputSubmit;
export 'src/widgets/additional/input_telephone.dart' show InputTelephone;
export 'src/widgets/additional/input_text.dart' show InputText;
export 'src/widgets/additional/input_time.dart' show InputTime;
export 'src/widgets/additional/input_url.dart' show InputUrl;
export 'src/widgets/additional/input_week.dart' show InputWeek;
