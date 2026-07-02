#import "resume.typ": *

#let data = toml("../../../content/resume/resume.toml")

#show: resume.with(
  page-margin: 0.8cm,
  font-size: 10pt,
  line-spacing: 0.45em,
)

#render-basics(data.basics)

#render-work(
  "Experience",
  data.work,
  mode: "grouped",
)

#render-education(
  "Education",
  data.education,
  mode: "collapsed",
)

#render-projects(
  "Projects",
  data.projects,
  mode: "collapsed",
)

#render-skills(
  "Skills",
  data.skills,
)
