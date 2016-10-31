angular.module('loomioApp').directive 'groupProgressCard', ->
  scope: { group: '=?', discussion: '=?' }
  restrict: 'E'
  templateUrl: 'generated/components/group_progress_card/group_progress_card.html'
  replace: true
  controller: ($scope, Session, Records, IntercomService) ->
    $scope.group = $scope.group || $scope.discussion.group()
    $scope.dismissed = false

    $scope.show = ->
      $scope.group.createdAt.isAfter(moment("2016-10-18")) &&
      Session.user().isAdminOf($scope.group) &&
      !Session.user().hasExperienced("dismissProgressCard", $scope.group)

    $scope.userHasProfilePicture = ->
      Session.user().hasProfilePhoto()

    $scope.dismiss = ->
      Records.memberships.saveExperience("dismissProgressCard", Session.user().membershipFor($scope.group))
      $scope.dismissed = true

    $scope.groupHasMultipleMembers = ->
      $scope.group.membershipsCount > 1

    $scope.groupHasMultipleThreads = ->
      $scope.group.discussionsCount > 2

    $scope.groupHasMultipleProposals = ->
      $scope.group.motionsCount > 1

    $scope.groupSetupComplete = ->
      $scope.group.description &&
      $scope.group.hasCustomCover &&
      $scope.groupHasMultipleMembers() &&
      $scope.groupHasMultipleThreads() &&
      $scope.groupHasMultipleProposals()

    $scope.allTasksCompleted = ->
      $scope.groupSetupComplete() &&
      $scope.userHasProfilePicture()

    $scope.showContactUs = ->
      IntercomService.available()

    $scope.contactUs = ->
      IntercomService.contactUs()
