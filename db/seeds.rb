User.destroy_all

user = User.create({
  username: "chasm",
  email: "chas@munat.com",
  password: "rintintin",
  password_confirmation: "rintintin"
})