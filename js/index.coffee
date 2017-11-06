---
---

container = document.querySelector '#background'

LANDSCAPE_COUNT = 3
PORTRAIT_COUNT = 14
BACKGROUND_TRANSITION_TIME = 4000
TRANSITION_TIME = 3000

currentInterval = null

location = ->
  width = window.innerWidth

  if width < 576
    return '/assets/images/portrait'

  '/assets/images/landscape'

activate = (el) ->
  el.classList.add 'top'
  setTimeout ->
    el.classList.add 'visible'
    return true
  , TRANSITION_TIME

deactivate = (el) ->
  setTimeout ->
    el.classList.remove 'visible'
    setTimeout ->
      el.classList.remove 'top'
    , TRANSITION_TIME
    return true
  , TRANSITION_TIME

append = ->
  if currentInterval
    clearInterval currentInterval

  root = location()

  count = LANDSCAPE_COUNT

  if root == '/assets/images/portrait'
    count = PORTRAIT_COUNT

  container.innerHTML = ''

  elements = []

  for i in [1..count]
    el = document.createElement 'div'
    el.style.backgroundImage = "url(#{root}/#{i}.jpeg)"
    elements.push(el)
    container.appendChild el

  elements[0].classList.add('top')
  elements[0].classList.add('visible')

  index = 0

  currentInterval = setInterval ->
    next = (index + 1) % count

    activate(elements[next])
    deactivate(elements[index])

    index = next
    return true
  , BACKGROUND_TRANSITION_TIME

window.addEventListener 'load', append
window.addEventListener 'resize', append
