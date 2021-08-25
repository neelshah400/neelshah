import { Box, Heading } from '@chakra-ui/react'
import React from 'react'

export const Section = (props) => {
  const { name, id, children } = props
  return (
    <Box id={id} p={3}>
      <Heading as="h1">{name}</Heading>
      <Box pt={3}>
        {children}
      </Box>
    </Box>
  )
}