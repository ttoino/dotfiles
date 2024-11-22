{
  windowrulev2 = [
    # Games
    "tag +game, class:^steam_app_"
    "tag +game, class:[Mm]inecraft"

    "immediate, tag:game"

    # PiP
    "tag +pip, title:discord\\.com/popout"
    "tag +pip, title:Picture-in-Picture"

    "float, tag:pip"
    "move 100%-w-16 100%-w-16, tag:pip"
    "size 25% 25%, tag:pip"
    "noinitialfocus, tag:pip"
    "pin, tag:pip"
    "opacity 1, tag:pip"
    "noblur, tag:pip"
    "nodim, tag:pip"
    "opaque, tag:pip"

    # Shimeji
    "tag +shimeji, title:oneko"

    "float, tag:shimeji"
    "noblur, tag:shimeji"
    "nofocus, tag:shimeji"
    "noshadow, tag:shimeji"
    "noborder, tag:shimeji"
  ];

  layerrule = [
    # Ags
    "blur, ags-scrim"
    "order 1, ags-scrim"
    "order 1, ags-dismisser"
  ];
}
