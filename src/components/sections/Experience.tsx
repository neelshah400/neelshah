import { Wrap } from "@chakra-ui/react";
import ExperienceCard from "../ExperienceCard";

export const Experience = () => {
  const cards: {
    organization: string;
    location: string;
    dates: string;
    role: string;
    image: string;
    bullets: string[];
  }[] = [
    {
      organization: "Morgan Stanley",
      location: "New York, NY",
      dates: "Aug 2024 \u2013 Present",
      role: "Software Engineer (Analyst)",
      image: "/ms.png",
      bullets: [
        "Actively developing features for various business-critical initiatives within Lending, across various applications/services, using mainly Angular (TypeScript) for frontend and Spring Boot/Db2 (Java) for backend",
        "Demonstrated the feasibility of leveraging generative AI to eliminate bottlenecks in Origination (via a 90% reduction in manual effort for Operations) through prototyping of integrated document processing workflows, chatbots, graph-based agentic systems, and more (utilizing OCR, vision, structured outputs, tool calling, and various other techniques)",
      ],
    },
    {
      organization: "University of Maryland",
      location: "College Park, MD",
      dates: "Jan 2023 \u2013 May 2024",
      role: "Teaching Assistant",
      image: "/umd.png",
      bullets: [
        "Teaching assistant for CMSC131: Object-Oriented Programming I, an introductory computer science course taught using Java",
        "Conducted weekly office hours, providing guidance to students on class material and project-related questions",
        "Graded quizzes, exams, and projects for style and accuracy, offering constructive feedback to enhance students' understanding",
      ],
    },
    {
      organization: "Morgan Stanley",
      location: "New York, NY",
      dates: "Jun 2023 \u2013 Aug 2023",
      role: "Software Engineering Intern (Analyst)",
      image: "/ms.png",
      bullets: [
        "Enabled quick analysis of Lending data using complex ML models by developing a versatile, user-friendly platform for model training, evaluation, and inference, using React (TypeScript) for the frontend and Flask/Db2 (Python) for the backend",
        "Supported complex pipelines with preprocessing and feature selection steps as well as hyperparameter tuning via grid search",
        "Prototyped a tool for classifying and extracting information from financial documents using generative AI and OCR models",
      ],
    },
    {
      organization: "Capgemini Government Solutions",
      location: "McLean, VA",
      dates: "Jun 2022 \u2013 Aug 2022",
      role: "Technical Intern",
      image: "/capgemini.png",
      bullets: [
        "Reduced processing time by over 80% and enhanced data accuracy by developing a UiPath RPA bot to automate the provisioning of users in Salesforce using data exported weekly from an HR system (previously done manually by the SaaS team)",
        "Presented findings on viability of VR for work to top executives, following hands-on testing and extensive market research",
      ],
    },
    {
      organization: "Bloomberg",
      location: "Dayton, NJ",
      dates: "Jun 2021 \u2013 Aug 2021",
      role: "Software Engineering Intern",
      image: "/bloomberg.png",
      bullets: [
        "Reduced maintenance downtime for a fleet of 30,000+ servers powering the Bloomberg Terminal by enabling operators to set different retry actions per host on a real-time maintenance operations management dashboard (developed by the Fleet Automation Services team), using Angular (TypeScript) for the frontend and Django/PostgreSQL (Python) for the backend",
        "Containerized the Angular frontend using Docker and improved observability on the Django backend using Grafana",
      ],
    },
    {
      organization: "Bloomberg",
      location: "Dayton, NJ",
      dates: "Jul 2020 \u2013 Aug 2020",
      role: "Software Engineering Intern",
      image: "/bloomberg.png",
      bullets: [
        "Provided visibility into the efficiency/reliability of maintenance jobs for a fleet of 30,000+ servers powering the Bloomberg Terminal (maintained by the Environment Support Site Reliability Engineering team)",
        "Developed an interactive web application to visualize metrics such as runtime, failure rates, and failure reasons at the host, schedule, and cluster levels, using React (TypeScript) for the frontend and Django/PostgreSQL (Python) for the backend",
      ],
    },
  ];

  return (
    <Wrap spacing={5} align="center">
      {cards.map((card, index) => (
        <ExperienceCard key={index} {...card} />
      ))}
    </Wrap>
  );
};
