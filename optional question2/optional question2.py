def main():
    a, b, c, i, j, k = 0.0, 0.0, 0.0, 0.0, 0.0, 0.0

    print("请输入已知量 a, b, c, i, j, k: ")
    a, b, c, i, j, k = map(float, input().split())

    y = (k + i - j - 2 * a - 2 * c + 2 * b) / 2
    x = (j + i - k - 2 * a - 2 * b + 2 * c) / 2
    z = (k + j - i - 2 * b - 2 * c + 2 * a) / 2

    print(f"{x}, {y}, {z}")


if __name__ == "__main__":
    main()