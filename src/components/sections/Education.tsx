import { Wrap } from "@chakra-ui/react";
import ExperienceCard from "../ExperienceCard";

export const Education = () => {
  const cards: {
    organization: string;
    location: string;
    dates: string;
    role: string;
    image: string;
    bullets: string[];
  }[] = [
    {
      organization: "University of Maryland",
      location: "College Park, MD",
      dates: "Aug 2021 \u2013 May 2024",
      role: "B.S. Computer Science, Minor in Statistics",
      image: "/umd.png",
      bullets: [
        "Summa Cum Laude (GPA: 4.0/4.0)",
        "Dean's List",
        "College Park Scholars: Environment, Technology, & Economy Citation",
      ],
    },
    {
      organization: "South Brunswick High School",
      location: "Monmouth Jct, NJ",
      dates: "Sep 2017 \u2013 Jun 2021",
      role: "High School Diploma",
      image: "/sbhs.png",
      bullets: [
        "Activities: Science Olympiad, LaunchX Entrepreneurship Program, Computer Science Club, Chemistry Olympics",
        "Honor Societies: National Honor Society; Computer Science, Math, Business, Science, and Latin honor societies",
        "Awards: National Merit Scholar, 2020 NASA Conrad Innovator, AP Scholar with Distinction, High Honor Roll",
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
