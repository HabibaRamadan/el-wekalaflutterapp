abstract class FavoriteStates {}
class FavoriteInitState extends FavoriteStates {}
class SuccedAddFavorite extends FavoriteStates {}
class LoadingAddFavorite extends FavoriteStates {}
class AddFavoriteError extends FavoriteStates {}

class SuccedGetFavorite extends FavoriteStates {}
class LoadingGetFavorite extends FavoriteStates {}
class GetFavoriteError extends FavoriteStates {}

class LoadingDeleteFavorite extends FavoriteStates {}
class SuccedDeleteFavorite extends FavoriteStates {}
class DeleteFavoriteError extends FavoriteStates {}


class AddToHive  extends FavoriteStates {}
class RemoveFromHive  extends FavoriteStates {} 
class ChangeIcon extends FavoriteStates{}
