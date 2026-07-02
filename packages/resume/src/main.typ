#import "resume.typ": *

#show: resume.with(
  page-margin: 0.8cm,
  font-size: 10pt,
  line-spacing: 0.47em,
)

= Neel Shah
#headline(
  "Software Engineer",
  "New York, NY",
) \
#contact-info(
  link("tel:+17329251305")[(732) 925-1305],
  link("mailto:neelshah400@gmail.com"),
  clean-link("https://www.neelshah.dev"),
  clean-link("https://github.com/neelshah400"),
  clean-link("https://www.linkedin.com/in/neelshah400"),
)

== Experience
#h-line()

#experience(
  company: [Morgan Stanley],
  location: [New York, NY],
) \
#experience(
  title: [Software Engineer II (Associate)],
  dates: [Jan 2026 -- Present],
) \
#experience(
  title: [Software Engineer I (Analyst)],
  dates: [Aug 2024 -- Jan 2026],
)
- Designed scalable workflows for loan servicing systems and architected new functionality for high-throughput transaction processing services within Lending, using Angular (TypeScript) for frontend and Spring Boot/Db2 (Java) for backend
- Wrote unit/integration tests (JUnit) and created Splunk alerts/metrics to ensure production reliability and prevent regressions
- Deployed containerized applications using Docker/Kubernetes with CI/CD pipelines in a Private Cloud environment
- Demonstrated the feasibility of leveraging generative AI to eliminate bottlenecks in Origination (via a 90% reduction in manual effort for Operations) through prototyping of integrated document processing workflows, chatbots, graph-based agentic systems, and more (utilizing OCR, vision, structured outputs, tool calling, and various other techniques)

#experience(
  title: [Software Engineering Intern (Analyst)],
  dates: [Jun 2023 -- Aug 2023],
) \
- Enabled quick analysis of Lending data using complex ML models by developing a versatile, user-friendly platform for model training, evaluation, and inference, using React (TypeScript) for the frontend and Flask/Db2 (Python) for the backend
- Supported complex pipelines with preprocessing and feature selection steps as well as hyperparameter tuning via grid search
- Prototyped a tool for classifying and extracting information from financial documents using generative AI and OCR models

#experience(
  company: [Capgemini Government Solutions],
  location: [McLean, VA],
  title: [Technical Intern],
  dates: [Jun 2022 -- Aug 2022],
) \
- Reduced processing time by over 80% and enhanced data accuracy by developing a UiPath RPA bot to automate the provisioning of users in Salesforce using data exported weekly from an HR system (previously done manually by the SaaS team)
- Presented findings on viability of VR for work to top executives, following hands-on testing and extensive market research

#experience(
  company: [Bloomberg],
  location: [Dayton, NJ],
) \
#experience(
  title: [Software Engineering Intern],
  dates: [Jun 2021 -- Aug 2021],
) \
- Reduced maintenance downtime for a fleet of 30,000+ servers powering the Bloomberg Terminal by enabling operators to set different retry actions per host on a real-time maintenance operations management dashboard (developed by the Fleet Automation Services team), using Angular (TypeScript) for the frontend and Django/PostgreSQL (Python) for the backend
- Containerized the Angular frontend using Docker and improved observability on the Django backend using Grafana

#experience(
  title: [Software Engineering Intern],
  dates: [Jul 2020 -- Aug 2020],
) \
- Provided visibility into the efficiency/reliability of maintenance jobs for a fleet of 30,000+ servers powering the Bloomberg Terminal (maintained by the Environment Support Site Reliability Engineering team)
- Developed an interactive web application to visualize metrics such as runtime, failure rates, and failure reasons at the host, schedule, and cluster levels, using React (TypeScript) for the frontend and Django/PostgreSQL (Python) for the backend

== Education
#h-line()

#education(
  collapse: true,
  institution: [University of Maryland],
  location: [College Park, MD],
  degree: [B.S. Computer Science, Minor in Statistics],
  dates: [Aug 2021 -- May 2024],
) \
- Summa Cum Laude (GPA: 4.0/4.0) | College Park Scholars: Environment, Technology, & Economy Citation
- Teaching Assistant for CMSC131: Object-Oriented Programming I (Jan 2023 -- May 2024)

== Projects
#h-line()

#project(
  name: [MenuMuse],
  dates: [May 2024 -- Jun 2024],
  reference: clean-link("https://menumuse.neelshah.dev"),
) \
- Created an AI-powered restaurant search chatbot that you can chat with using natural language to search for restaurants, ask questions, summarize reviews, and more
- Built the site using React/Next.js (TypeScript) for the frontend/backend, Google's Gemini 1.5 Flash for chat completions, the Google Maps Platform Places API for restaurant information, and Redis for saving chat history

#project(
  name: [NBA Playoff Predictions],
  dates: [Jan 2023 -- May 2023],
  reference: clean-link("https://nba.neelshah.dev"),
) \
- Analyzed the factors influencing teams' playoff success using Python, going through each step of the data science pipeline
- Accurately predicted the number of playoff games a given team would win by leveraging regular season data to train 8 different ML models, with the best (a decision tree) achieving a mean deviation of less than 2.5 games
- Performed an exhaustive grid search with 5-fold cross-validation to find the optimal parameters for each model

== Skills
#h-line()

#skills(
  join-key: ", ",
  (
    group: [Programming Languages],
    items: (
      [Python],
      [JavaScript],
      [TypeScript],
      [Java],
      [C\#],
      [Haskell],
      [OCaml],
      [C],
    ),
  ),
  (
    group: [Web Development],
    items: (
      [HTML],
      [CSS],
      [React],
      [Angular],
      [FastAPI],
      [Flask],
      [Django],
      [Express],
      [Spring Boot],
      [ASP.NET],
    ),
  ),
  (
    group: [DevOps/Infrastructure],
    items: (
      [Linux],
      [Git],
      [Docker],
      [Kubernetes],
      [CI/CD],
      [SQL],
      [Redis],
      [MongoDB],
      [Kafka],
    ),
  ),
  (
    group: [AI/ML/Automation],
    items: (
      [Generative AI],
      [Data Science],
      [Machine Learning],
      [Robotic Process Automation],
    ),
  ),
)
