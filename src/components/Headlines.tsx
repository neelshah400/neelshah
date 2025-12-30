import { Text, useBreakpointValue } from '@chakra-ui/react'
import React from 'react'

export const Headlines = () => {

  const headlines: string[] = useBreakpointValue({
    base: [
      'Software Engineer (Analyst) @ Morgan Stanley',
      'CS @ UMD',
    ],
    sm: [
      'Software Engineer (Analyst) at Morgan Stanley',
      'B.S. Computer Science at University of Maryland',
    ]
  })

  return headlines ? <>
    {headlines.map((headline, index) => (
      <Text key={index} align="center" fontSize="2xl" pt={index === 0 ? 10 : 0} flexGrow={index === headlines.length - 1 ? 1 : 0}>
        {headline}
      </Text>
    ))}
  </> : <></>

}