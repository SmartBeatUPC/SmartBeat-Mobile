extension ExtensionDynamic on dynamic {
  T? castOr<T>([T Function()? supplier]) {
    if (this != null) return this as T;
    return supplier != null ? supplier() : null;
  }
}
