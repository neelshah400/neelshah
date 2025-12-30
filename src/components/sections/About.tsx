import { Text } from "@chakra-ui/react";
import React from "react";

export const About = () => {
  const paragraphs: string[] = [
    "Hi, I'm Neel! I'm a Software Engineer based in New York, passionate about building solutions that make a real impact. I graduated Summa Cum Laude from the University of Maryland in 2024 with a degree in Computer Science and a minor in Statistics.",
    "I've had the chance to work at places like Morgan Stanley, Capgemini Government Solutions, and Bloomberg, where I've tackled everything from full-stack web development to AI-driven automation. Whether it's building user-friendly platforms, optimizing business processes, or experimenting with the latest in generative AI, I love solving tough problems and learning something new every day.",
    "I'm always eager to learn, collaborate, and take on new challenges. If you'd like to connect, discuss opportunities, or chat about tech, feel free to reach out!",
  ];

  return (
    <>
      {paragraphs.map((paragraph, index) => (
        <Text key={index} pt={index === 0 ? 0 : 3} fontSize="lg">
          {paragraph}
        </Text>
      ))}
    </>
  );
};
