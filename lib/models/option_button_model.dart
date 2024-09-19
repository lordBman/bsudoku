class OptionButtonModel {
    final String title;
    final String? subTitle;
    final bool disabled, selected;
    final Function() onTap;

    OptionButtonModel({ required this.title, required this.onTap, this.subTitle, this.disabled = false, this.selected = false });
}