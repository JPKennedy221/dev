<template><ResourcePage :resource="String($route.params.resource)" :title="String($route.params.resource).replace(/-/g, ' ').replace(/\b\w/g, c => c.toUpperCase())" /></template>
