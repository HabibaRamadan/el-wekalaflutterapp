abstract class CartStates {}

class CartInitState extends CartStates {}

class SuccedAddToCart extends CartStates {}
class LoadingAddToCart extends CartStates {}
class AddToCartError extends CartStates {}

class SuccedGetCart extends CartStates {}
class LoadingGetCart extends CartStates {}
class GetFromCartError extends CartStates {}

class LoadingDeleteCart extends CartStates {}
class SuccedDeleteCart extends CartStates {}
class DeleteCartError extends CartStates {}

class LoadingUpdateCart extends CartStates {}
class SuccedUpdateCart extends CartStates {}
class UpdateCartError extends CartStates {}