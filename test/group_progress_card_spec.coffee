describe 'Group progress card', ->

  page = require '../../../angular/test/protractor/helpers/page_helper.coffee'
  staticPage = require '../../../angular/test/protractor/helpers/static_page_helper.coffee'

  it 'is only visible to group coordinators of parent groups', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.expectText '.group-progress-card', 'ACTIVATE YOUR GROUP'
    page.click '.subgroups-card__list-item-name a'
    page.expectNoText '.group-page', 'ACTIVATE YOUR GROUP'

  it 'is is not visible to non-coordinators', ->
    page.loadPath 'setup_progress_card_member'
    page.expectNoText '.group-page', 'ACTIVATE YOUR GROUP'

  it 'adds a tick to completed tasks', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.expectText '.group-progress-card', '✅'

  it 'displays a celebratory message when setup is complete', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.clickLast '.thread-preview__link'
    page.click '.start-proposal-button__button'
    page.fillIn '.proposal-form__title-field', 'New proposal'
    page.click '.proposal-form__start-btn'
    page.expectText '.group-progress-card', "Nice! Your group is good to go!"

  it 'can be dismissed', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.click '.group-progress-card__dismiss'
    page.expectNoText '.group-page', 'ACTIVATE YOUR GROUP'

  it 'reappears when user starts a new group', ->
    page.loadPath 'setup_progress_card_coordinator'
    page.click '.group-progress-card__dismiss'
    page.click '.start-menu__start-button',
               '.start-menu__startGroup'
    page.fillIn '#group-name', 'Freshest group'
    page.click '.group-form__submit-button'
    page.expectText '.group-page', 'ACTIVATE YOUR GROUP'
