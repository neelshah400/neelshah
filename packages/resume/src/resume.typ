// A state variable for the default join key (the content placed between
// elements when joining them, if applicable).
#let state-default-join-key = state("default-join-key", none)

// A state variable for whether to collapse section headers by default (if
// collapsed, a section header takes 1 line instead of 2 lines).
#let state-default-collapse-section-headers = state(
  "default-collapse-section-headers",
  none,
)

// A resume template, with configurable styles.
#let resume(
  page-paper: "us-letter",
  page-margin: 1cm,
  font-family: "New Computer Modern",
  font-size: 11pt,
  par-justify: true,
  line-spacing: 0.65em,
  line-stroke: 0.5pt,
  default-join-key: " | ",
  default-collapse-section-headers: false,
  doc,
) = {
  // Apply styles.
  set page(paper: page-paper, margin: page-margin)
  set text(font: font-family, size: font-size)
  set par(justify: par-justify, leading: line-spacing)
  set grid(gutter: line-spacing)
  set line(stroke: line-stroke)

  // Set state variables for the default parameters.
  state-default-join-key.update(default-join-key)
  state-default-collapse-section-headers.update(
    default-collapse-section-headers,
  )

  // Render the document.
  doc
}

// Returns the provided parameter if it is not none, otherwise gets the
// default parameter from a state variable.
#let param-or-state-default(param, default) = context {
  if param == none {
    default.get()
  } else {
    param
  }
}

// Returns a horizontal line, intended for use between main resume sections.
#let h-line() = {
  v(-3pt)
  line(length: 100%)
  v(-5pt)
}

// Returns a link with a clean URL as its body, given a destination URL.
//
// `https://`, `http://`, and `www.` are removed from the start of the URL, if
// present.
//
// Any trailing `/` is removed from the end of the URL.
#let clean-link(dest) = {
  if (dest == none) {
    link(dest)
  } else {
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
  }
}

// Returns the subset of the provided elements which are not none, joined by the
// specified join key (if provided) or the default join key.
#let join-optional(join-key: none, ..elements) = {
  let key = param-or-state-default(join-key, state-default-join-key)
  elements.pos().filter(x => x != none).join(key)
}

// Returns the result of applying the provided function to the provided element
// if it is not none, otherwise returns none.
#let map-optional(fn, element) = {
  if element != none {
    fn(element)
  } else {
    none
  }
}

// A headline section.
//
// Returns the provided elements joined by the specified join key (if provided)
// or the default join key.
#let headline(join-key: none, ..elements) = {
  elements.pos().join(param-or-state-default(join-key, state-default-join-key))
}

// A contact info section.
//
// Returns the provided elements joined by the specified join key (if provided)
// or the default join key.
#let contact-info(join-key: none, ..elements) = {
  elements.pos().join(param-or-state-default(join-key, state-default-join-key))
}

// A reusable collapsible section header.
//
// The section header will be collapsed if indicated, or if the default section
// header collapse is enabled.
//
// If collapsed, the section header takes 1 line, in the following form
// (where ` | ` is a placeholder for the join key):
//
// ```
// top-left | bottom-left                     top-right | bottom-right
// ```
//
// If not collapsed, the section header takes 2 lines, in the following form:
//
// ```
// top-left                                                  top-right
// bottom-left                                            bottom-right
// ```
#let collapsible-section-header(
  collapse: none,
  join-key: none,
  top-left: none,
  top-right: none,
  bottom-left: none,
  bottom-right: none,
) = context {
  let formatted-top-left = map-optional(strong, top-left)
  let formatted-top-right = map-optional(emph, top-right)
  let formatted-bottom-left = map-optional(emph, bottom-left)
  let formatted-bottom-right = map-optional(emph, bottom-right)
  if (
    collapse == true
      or (collapse == none and state-default-collapse-section-headers.get())
  ) {
    let key = param-or-state-default(join-key, state-default-join-key)
    [
      #join-optional(join-key: key, formatted-top-left, formatted-bottom-left)
      #h(1fr)
      #join-optional(join-key: key, formatted-top-right, formatted-bottom-right)
    ]
  } else {
    let top = join-optional(
      formatted-top-left,
      formatted-top-right,
      join-key: h(1fr),
    )
    let bottom = join-optional(
      formatted-bottom-left,
      formatted-bottom-right,
      join-key: h(1fr),
    )
    [#join-optional(join-key: linebreak(), top, bottom)]
  }
}

// An experience section.
//
// Returns a collapsible section header as follows:
// - top-left: company
// - top-right: location
// - bottom-left: title
// - bottom-right: dates
#let experience(
  collapse: none,
  join-key: none,
  company: none,
  dates: none,
  title: none,
  location: none,
) = {
  collapsible-section-header(
    collapse: collapse,
    join-key: join-key,
    top-left: company,
    top-right: location,
    bottom-left: title,
    bottom-right: dates,
  )
}

// An education section.
//
// Returns a collapsible section header as follows:
// - top-left: institution
// - top-right: location
// - bottom-left: degree
// - bottom-right: dates
#let education(
  collapse: none,
  join-key: none,
  institution: none,
  location: none,
  degree: none,
  dates: none,
) = {
  collapsible-section-header(
    collapse: collapse,
    join-key: join-key,
    top-left: institution,
    top-right: location,
    bottom-left: degree,
    bottom-right: dates,
  )
}

// A project section.
//
// Returns a default-collapsed section header as follows:
// - top-left: name
// - top-right: dates
// - bottom-left: reference
#let project(
  collapse: true,
  join-key: none,
  name: none,
  dates: none,
  reference: none,
) = {
  collapsible-section-header(
    collapse: collapse,
    join-key: join-key,
    top-left: name,
    top-right: dates,
    bottom-left: reference,
  )
}

// A skills section.
//
// Returns a 2-column grid of skill groups and items, joined by the specified
// join key (if provided) or the default join key.
//
// Each skill group is appended by the group suffix and rendered in bold.
#let skills(
  group-suffix: ":",
  join-key: none,
  ..elements,
) = {
  let key = param-or-state-default(join-key, state-default-join-key)
  let children = elements
    .pos()
    .map(e => (strong(e.group + group-suffix), e.items.join(key)))
    .flatten()
  grid(
    columns: 2,
    ..children
  )
}
