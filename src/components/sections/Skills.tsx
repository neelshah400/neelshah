import { Wrap } from "@chakra-ui/react";
import React from "react";
import SkillsCard from "../SkillsCard";

export const Skills = () => {
  const cards: {
    name: string;
    icon: string;
    skills: { name: string; icon: string }[];
  }[] = [
    {
      name: "Programming Languages",
      icon: "mdi:code",
      skills: [
        { name: 'Python', icon: 'vscode-icons:file-type-python' },
        { name: 'JavaScript', icon: 'vscode-icons:file-type-js-official' },
        { name: 'TypeScript', icon: 'vscode-icons:file-type-typescript-official' },
        { name: "Java", icon: "vscode-icons:file-type-java" },
        { name: "C#", icon: "vscode-icons:file-type-csharp2" },
        { name: "Haskell", icon: "vscode-icons:file-type-haskell" },
        { name: "OCaml", icon: "vscode-icons:file-type-ocaml" },
        { name: "C", icon: "vscode-icons:file-type-c" },
      ],
    },
    {
      name: "Web Development",
      icon: "mdi:web",
      skills: [
        { name: "HTML", icon: "vscode-icons:file-type-html" },
        { name: "CSS", icon: "vscode-icons:file-type-css" },
        { name: "React", icon: "vscode-icons:file-type-reactjs" },
        { name: "Angular", icon: "vscode-icons:file-type-angular" },
        { name: "FastAPI", icon: "logos:fastapi-icon" },
        { name: "Flask", icon: "file-icons:flask" },
        { name: "Django", icon: "vscode-icons:file-type-django" },
        { name: "Express", icon: "simple-icons:express" },
        { name: "Spring Boot", icon: "logos:spring-icon" },
        { name: "ASP.NET", icon: "logos:dotnet" },
      ],
    },
    {
      name: "DevOps/Infrastructure",
      icon: "mdi:cloud-outline",
      skills: [
        { name: "Linux", icon: "logos:linux-tux" },
        { name: "Git", icon: "vscode-icons:file-type-git" },
        { name: "Docker", icon: "logos:docker-icon" },
        { name: "Kubernetes", icon: "logos:kubernetes" },
        { name: "SQL", icon: "vscode-icons:file-type-sql" },
        { name: "Redis", icon: "logos:redis" },
        { name: "MongoDB", icon: "logos:mongodb-icon" },
        { name: "Kafka", icon: "simple-icons:apachekafka" },
      ],
    },
    {
      name: "AI/ML/Automation",
      icon: "mdi:robot-outline",
      skills: [
        { name: "Generative AI", icon: "fa7-brands:openai" },
        { name: "Data Science", icon: "logos:pandas-icon" },
        { name: "Machine Learning", icon: "logos:pytorch-icon" },
        { name: "Robotic Process Automation", icon: "/uipath.png" },
      ],
    },
  ];

  return (
    <Wrap spacing={5} align="center">
      {cards.map((card) => (
        <SkillsCard
          key={card.name}
          name={card.name}
          icon={card.icon}
          skills={card.skills}
        />
      ))}
    </Wrap>
  );
};
