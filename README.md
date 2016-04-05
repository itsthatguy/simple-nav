# simple-nav

### Installationg

```
npm install simple-nav --save
```

### Javascript

#### with NPM

```javascript
SimpleNav = require('simple-nav')

myNavigation = new SimpleNav({
  // defaults
  scrolledClass: 'scrolled'
  expandedClass: 'open'
  scrollTolerance: 120
  gotoSpeed: 10

  gotoAnchorTimer: 500
  handleScrollTimer: 300
  toggleMenuTimer: 300
});
```

### Scss

```scss
$small: "only screen and (min-width: 40.063em)";

nav.primary-navigation {
  > h1 {
    @include inline-block;
  }

  > .menu {
    @include inline-icon('menu');
    display: block;
    position: absolute;
    right: 10px;
    top: 10px;

    span { display: none; }
  }

  > ul.nav-links {
    display: none;
    float: right;

    li {
      @include inline-block;
      margin-right: rem-calc(10px);
      margin-top: rem-calc(12px);
    }
  }

  .button {
    @include inline-block;
    margin-bottom: 0;
    margin-top: rem-calc(-2px);
    padding: rem-calc(4px 6px);
  }

  @media #{$small} {
    > .menu { display: none; }

    > ul.nav-links {
      display: block;
    }
  }

  // When the body tag has the open class applied
  body.open & {
    > ul.nav-links { display: block; }
  }
}
```

## Markup
```haml
%nav.primary-navigation
  - # Title & Menu Icon
  %h1 Title
  %a.menu(href="#") <span>Menu</span>

  - # Nav links
  %ul.nav-links
    %li
      %a(href="some-link") Some Link
    %li
      %a(href="some-other-link") Some Other Link
    %li
      %a.button(href="AWESOME") AWESOME
```
