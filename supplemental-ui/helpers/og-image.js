'use strict'

module.exports = (page) => page['attributes']['og-image'].startsWith('http') ? page['attributes']['og-image'] : '../'.repeat((page['attributes']['relative'].match(/\//g) || []).length) + '_images/' + page['attributes']['og-image'];
