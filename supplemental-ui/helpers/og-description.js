'use strict'

const TAG_ALL_RX = /<[^>]+>/g
const TAG_HEADERS = /<h[0-9][^>]*>.+?<\/h[0-9]>/g

module.exports = (html) => html && html
    .toString()
    .replace(TAG_HEADERS, '')
    .replace(TAG_ALL_RX, '')
    .trim()
    .replace(/\n/g, ' ')
    .substr(0, 140) + '...'
