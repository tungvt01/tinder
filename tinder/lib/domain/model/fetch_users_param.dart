class FetchUsersParams {
  int page;
  int limit;
  FetchUsersParams({
    this.page = 0,
    this.limit = 10,
  });

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "limit": limit,
    };
  }
}
