{ modules, ... }:
{
  modules = with modules; [
    calendar
    contacts
    email
  ];
}
