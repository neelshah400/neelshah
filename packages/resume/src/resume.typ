// Indicates whether a value is empty (not present).
#let _is-empty(value) = value == none or value == "" or value == ()

// Applies a function to a present value.
#let _map-optional(value, fn: value => value) = {
  if _is-empty(value) {
    none
  } else {
    fn(value)
  }
}

// Filters present values from a sequence.
#let _filter-optional(values, fn: value => value) = {
  (if values == none { () } else { values })
    .map(value => _map-optional(value, fn: fn))
    .filter(value => value != none)
}

// Joins present values.
#let _join-optional(join-key: " | ", ..elements) = {
  _filter-optional(elements.pos()).join(join-key)
}

// Formats a link.
#let _format-link(dest) = _map-optional(
  dest,
  fn: dest => {
    let body = dest
    if body.starts-with("https://") {
      body = body.slice(8)
    } else if body.starts-with("http://") {
      body = body.slice(7)
    }
    if body.starts-with("www.") {
      body = body.slice(4)
    }
    if body.ends-with("/") {
      body = body.slice(0, -1)
    }
    link(dest)[#body]
  },
)

// Formats an email address.
#let _format-email(email) = _map-optional(
  email,
  fn: email => link("mailto:" + email),
)

// Formats a phone number.
#let _format-phone(phone) = _map-optional(
  phone,
  fn: phone => {
    let digits = phone
      .clusters()
      .filter(char => char >= "0" and char <= "9")
      .join()
    let body = if phone.starts-with("+1") and digits.len() == 11 {
      let national = digits.slice(1)
      [(#national.slice(0, 3)) #national.slice(3, 6)-#national.slice(6, 10)]
    } else {
      phone
    }
    link("tel:" + phone)[#body]
  },
)

// Formats a date.
#let _format-date(date) = _map-optional(
  date,
  fn: date => datetime(
    year: int(date.slice(0, 4)),
    month: int(date.slice(5, 7)),
    day: int(date.slice(8, 10)),
  ).display("[month repr:short] [year]"),
)

// Formats a date range.
#let _format-date-range(start, end) = {
  let start = _format-date(start)
  let end = _format-date(end)
  if _is-empty(start) {
    end
  } else if _is-empty(end) {
    start + " -- Present"
  } else {
    start + " -- " + end
  }
}

// Formats a location.
#let _format-location(location, include-country: false) = _map-optional(
  location,
  fn: location => _map-optional(
    _filter-optional(
      (
        location.at("city", default: none),
        location.at("region", default: none),
        if include-country {
          location.at("countryCode", default: none)
        } else {
          none
        },
      ),
    ),
    fn: parts => parts.join(", "),
  ),
)

// Formats an education degree.
#let _format-education-degree(entry) = {
  let study-type = _map-optional(entry.at("studyType", default: none))
  let area = _map-optional(entry.at("area", default: none))
  let score = _map-optional(entry.at("score", default: none))

  _map-optional(
    study-type,
    fn: study-type => [
      #_join-optional(study-type, area, join-key: " ")
      #_map-optional(score, fn: score => [ (GPA: #score)])
    ],
  )
}

// Renders bullets when items are present.
#let _render-bullets(items) = _map-optional(
  _filter-optional(items),
  fn: items => [
    #for item in items [
      - #item
    ]
  ],
)

// Renders a details entry header.
#let _render-details-entry-header(
  collapse: false,
  join-key: " | ",
  top-left: none,
  top-right: none,
  bottom-left: none,
  bottom-right: none,
) = {
  let formatted-top-left = _map-optional(top-left, fn: strong)
  let formatted-top-right = _map-optional(top-right, fn: emph)
  let formatted-bottom-left = _map-optional(bottom-left, fn: emph)
  let formatted-bottom-right = _map-optional(bottom-right, fn: emph)

  if collapse {
    [
      #_join-optional(
        formatted-top-left,
        formatted-bottom-left,
        join-key: join-key,
      )
      #h(1fr)
      #_join-optional(
        formatted-top-right,
        formatted-bottom-right,
        join-key: join-key,
      )
    ]
  } else {
    [
      #_join-optional(
        _join-optional(
          formatted-top-left,
          formatted-top-right,
          join-key: h(1fr),
        ),
        _join-optional(
          formatted-bottom-left,
          formatted-bottom-right,
          join-key: h(1fr),
        ),
        join-key: linebreak(),
      )
    ]
  }
}

// Renders details when entries are present.
#let _render-details(
  entries,
  mode: "expanded",
  top-left: entry => none,
  top-right: entry => none,
  bottom-left: entry => none,
  bottom-right: entry => none,
  items: entry => none,
) = _map-optional(
  entries,
  fn: entries => {
    let collapse = mode == "collapsed"
    let present-top-left = entry => _map-optional(top-left(entry))
    let present-top-right = entry => _map-optional(top-right(entry))
    let present-bottom-left = entry => _map-optional(bottom-left(entry))
    let present-bottom-right = entry => _map-optional(bottom-right(entry))
    [
      #for index in range(entries.len()) [
        #let entry = entries.at(index)
        #let current-top-left = present-top-left(entry)

        #if mode == "grouped" and current-top-left != none [
          #let previous-entry = if index == 0 { none } else {
            entries.at(index - 1)
          }
          #let starts-group = (
            previous-entry == none
              or current-top-left != present-top-left(previous-entry)
          )

          #if starts-group [
            #_render-details-entry-header(
              top-left: current-top-left,
              top-right: present-top-right(entry),
              bottom-left: present-bottom-left(entry),
              bottom-right: present-bottom-right(entry),
            ) \
          ] else [
            #_render-details-entry-header(
              bottom-left: present-bottom-left(entry),
              bottom-right: present-bottom-right(entry),
            ) \
          ]
        ] else [
          #_render-details-entry-header(
            collapse: collapse,
            top-left: current-top-left,
            top-right: present-top-right(entry),
            bottom-left: present-bottom-left(entry),
            bottom-right: present-bottom-right(entry),
          ) \
        ]
        #_render-bullets(items(entry))
      ]
    ]
  },
)

// Renders groups when entries are present.
#let _render-groups(
  entries,
  group: _entry => none,
  items: entry => entry,
  join-key: ", ",
) = {
  let groups = _filter-optional(
    entries,
    fn: entry => _map-optional(
      _filter-optional(items(entry)),
      fn: items => (
        group: _map-optional(group(entry)),
        items: items,
      ),
    ),
  )

  _map-optional(groups, fn: groups => {
    let group-items = group => group.items.join(join-key)

    if groups.all(group => group.group == none) {
      groups.map(group => group-items(group)).join(linebreak())
    } else {
      let children = groups
        .map(group => (
          if group.group == none { none } else { strong(group.group + ":") },
          group-items(group),
        ))
        .flatten()
      grid(columns: 2, ..children)
    }
  })
}

// Renders a header when heading is present.
#let _render-header(heading, content) = _map-optional(
  heading,
  fn: heading => [
    = #heading
    #_map-optional(content)
  ],
)

// Renders a section when content is present.
#let _render-section(heading, content) = _map-optional(
  content,
  fn: content => [
    == #heading
    #v(-3pt)
    #line(length: 100%)
    #v(-5pt)
    #content
  ],
)

// Renders the basics header.
#let render-basics(basics) = _render-header(
  basics.at("name", default: none),
  _render-groups(
    (
      (
        basics.at("label", default: none),
        _format-location(basics.at("location", default: none)),
      ),
      (
        _format-phone(basics.at("phone", default: none)),
        _format-email(basics.at("email", default: none)),
        _format-link(basics.at("url", default: none)),
        .._filter-optional(
          basics.at("profiles", default: ()),
          fn: profile => _format-link(profile.at("url", default: none)),
        ),
      ),
    ),
    join-key: " | ",
  ),
)

// Renders the work section.
#let render-work(
  heading,
  entries,
  mode: "grouped",
) = _render-section(
  heading,
  _render-details(
    entries,
    mode: mode,
    top-left: entry => entry.at("name", default: none),
    top-right: entry => entry.at("location", default: none),
    bottom-left: entry => entry.at("position", default: none),
    bottom-right: entry => _format-date-range(
      entry.at("startDate", default: none),
      entry.at("endDate", default: none),
    ),
    items: entry => entry.at("highlights", default: ()),
  ),
)

// Renders the education section.
#let render-education(
  heading,
  entries,
  mode: "collapsed",
) = _render-section(
  heading,
  _render-details(
    entries,
    mode: mode,
    top-left: entry => entry.at("institution", default: none),
    top-right: entry => entry.at("location", default: none),
    bottom-left: _format-education-degree,
    bottom-right: entry => _format-date-range(
      entry.at("startDate", default: none),
      entry.at("endDate", default: none),
    ),
    items: entry => entry.at("highlights", default: ()),
  ),
)

// Renders the projects section.
#let render-projects(
  heading,
  entries,
  mode: "collapsed",
) = _render-section(
  heading,
  _render-details(
    entries,
    mode: mode,
    top-left: entry => entry.at("name", default: none),
    bottom-left: entry => _format-link(entry.at("url", default: none)),
    bottom-right: entry => _format-date-range(
      entry.at("startDate", default: none),
      entry.at("endDate", default: none),
    ),
    items: entry => entry.at("highlights", default: ()),
  ),
)

// Renders the skills section.
#let render-skills(
  heading,
  entries,
) = _render-section(
  heading,
  _render-groups(
    entries,
    group: entry => entry.at("name", default: none),
    items: entry => entry.at("keywords", default: ()),
  ),
)

// Applies the resume page styling.
#let resume(
  page-paper: "us-letter",
  page-margin: 1cm,
  font-family: "New Computer Modern",
  font-size: 11pt,
  par-justify: true,
  line-spacing: 0.65em,
  line-stroke: 0.5pt,
  doc,
) = {
  set page(paper: page-paper, margin: page-margin)
  set text(font: font-family, size: font-size)
  set par(justify: par-justify, leading: line-spacing)
  set grid(gutter: line-spacing)
  set line(stroke: line-stroke)

  doc
}
