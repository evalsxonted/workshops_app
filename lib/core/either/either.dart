class Either<L, R>{
  L left;
  R right;
  bool get isFailed => left!=null;
  Either(this.left, this.right);
}