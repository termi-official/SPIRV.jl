module SPIRVVulkanExt

using MLStyle: @match
import SPIRV
using Vulkan: Vk

# The following is a copy-paste from the Vulkan specification.
# See https://registry.khronos.org/vulkan/specs/1.3-extensions/html/chap50.html#spirvenv-image-formats

Vk.Format(spirv_format::SPIRV.ImageFormat) = @match spirv_format begin
  &SPIRV.ImageFormatR8 => Vk.FORMAT_R8_UNORM
  &SPIRV.ImageFormatR8Snorm => Vk.FORMAT_R8_SNORM
  &SPIRV.ImageFormatR8ui => Vk.FORMAT_R8_UINT
  &SPIRV.ImageFormatR8i => Vk.FORMAT_R8_SINT
  &SPIRV.ImageFormatRg8 => Vk.FORMAT_R8G8_UNORM
  &SPIRV.ImageFormatRg8Snorm => Vk.FORMAT_R8G8_SNORM
  &SPIRV.ImageFormatRg8ui => Vk.FORMAT_R8G8_UINT
  &SPIRV.ImageFormatRg8i => Vk.FORMAT_R8G8_SINT
  &SPIRV.ImageFormatRgba8 => Vk.FORMAT_R8G8B8A8_UNORM
  &SPIRV.ImageFormatRgba8Snorm => Vk.FORMAT_R8G8B8A8_SNORM
  &SPIRV.ImageFormatRgba8ui => Vk.FORMAT_R8G8B8A8_UINT
  &SPIRV.ImageFormatRgba8i => Vk.FORMAT_R8G8B8A8_SINT
  &SPIRV.ImageFormatRgb10A2 => Vk.FORMAT_A2B10G10R10_UNORM_PACK32
  &SPIRV.ImageFormatRgb10a2ui => Vk.FORMAT_A2B10G10R10_UINT_PACK32
  &SPIRV.ImageFormatR16 => Vk.FORMAT_R16_UNORM
  &SPIRV.ImageFormatR16Snorm => Vk.FORMAT_R16_SNORM
  &SPIRV.ImageFormatR16ui => Vk.FORMAT_R16_UINT
  &SPIRV.ImageFormatR16i => Vk.FORMAT_R16_SINT
  &SPIRV.ImageFormatR16f => Vk.FORMAT_R16_SFLOAT
  &SPIRV.ImageFormatRg16 => Vk.FORMAT_R16G16_UNORM
  &SPIRV.ImageFormatRg16Snorm => Vk.FORMAT_R16G16_SNORM
  &SPIRV.ImageFormatRg16ui => Vk.FORMAT_R16G16_UINT
  &SPIRV.ImageFormatRg16i => Vk.FORMAT_R16G16_SINT
  &SPIRV.ImageFormatRg16f => Vk.FORMAT_R16G16_SFLOAT
  &SPIRV.ImageFormatRgba16 => Vk.FORMAT_R16G16B16A16_UNORM
  &SPIRV.ImageFormatRgba16Snorm => Vk.FORMAT_R16G16B16A16_SNORM
  &SPIRV.ImageFormatRgba16ui => Vk.FORMAT_R16G16B16A16_UINT
  &SPIRV.ImageFormatRgba16i => Vk.FORMAT_R16G16B16A16_SINT
  &SPIRV.ImageFormatRgba16f => Vk.FORMAT_R16G16B16A16_SFLOAT
  &SPIRV.ImageFormatR32ui => Vk.FORMAT_R32_UINT
  &SPIRV.ImageFormatR32i => Vk.FORMAT_R32_SINT
  &SPIRV.ImageFormatR32f => Vk.FORMAT_R32_SFLOAT
  &SPIRV.ImageFormatRg32ui => Vk.FORMAT_R32G32_UINT
  &SPIRV.ImageFormatRg32i => Vk.FORMAT_R32G32_SINT
  &SPIRV.ImageFormatRg32f => Vk.FORMAT_R32G32_SFLOAT
  &SPIRV.ImageFormatRgba32ui => Vk.FORMAT_R32G32B32A32_UINT
  &SPIRV.ImageFormatRgba32i => Vk.FORMAT_R32G32B32A32_SINT
  &SPIRV.ImageFormatRgba32f => Vk.FORMAT_R32G32B32A32_SFLOAT
  &SPIRV.ImageFormatR64ui => Vk.FORMAT_R64_UINT
  &SPIRV.ImageFormatR64i => Vk.FORMAT_R64_SINT
  &SPIRV.ImageFormatR11fG11fB10f => Vk.FORMAT_B10G11R11_UFLOAT_PACK32
  &SPIRV.ImageFormatUnknown => Vk.FORMAT_UNDEFINED
  _ => error("Unknown SPIR-V image format $spirv_format")
end

SPIRV.ImageFormat(vk_format::Vk.Format) = @match vk_format begin
  &Vk.FORMAT_R8_UNORM => SPIRV.ImageFormatR8
  &Vk.FORMAT_R8_SNORM => SPIRV.ImageFormatR8Snorm
  &Vk.FORMAT_R8_UINT => SPIRV.ImageFormatR8ui
  &Vk.FORMAT_R8_SINT => SPIRV.ImageFormatR8i
  &Vk.FORMAT_R8G8_UNORM => SPIRV.ImageFormatRg8
  &Vk.FORMAT_R8G8_SNORM => SPIRV.ImageFormatRg8Snorm
  &Vk.FORMAT_R8G8_UINT => SPIRV.ImageFormatRg8ui
  &Vk.FORMAT_R8G8_SINT => SPIRV.ImageFormatRg8i
  &Vk.FORMAT_R8G8B8A8_UNORM => SPIRV.ImageFormatRgba8
  &Vk.FORMAT_R8G8B8A8_SNORM => SPIRV.ImageFormatRgba8Snorm
  &Vk.FORMAT_R8G8B8A8_UINT => SPIRV.ImageFormatRgba8ui
  &Vk.FORMAT_R8G8B8A8_SINT => SPIRV.ImageFormatRgba8i
  &Vk.FORMAT_A2B10G10R10_UNORM_PACK32 => SPIRV.ImageFormatRgb10A2
  &Vk.FORMAT_A2B10G10R10_UINT_PACK32 => SPIRV.ImageFormatRgb10a2ui
  &Vk.FORMAT_R16_UNORM => SPIRV.ImageFormatR16
  &Vk.FORMAT_R16_SNORM => SPIRV.ImageFormatR16Snorm
  &Vk.FORMAT_R16_UINT => SPIRV.ImageFormatR16ui
  &Vk.FORMAT_R16_SINT => SPIRV.ImageFormatR16i
  &Vk.FORMAT_R16_SFLOAT => SPIRV.ImageFormatR16f
  &Vk.FORMAT_R16G16_UNORM => SPIRV.ImageFormatRg16
  &Vk.FORMAT_R16G16_SNORM => SPIRV.ImageFormatRg16Snorm
  &Vk.FORMAT_R16G16_UINT => SPIRV.ImageFormatRg16ui
  &Vk.FORMAT_R16G16_SINT => SPIRV.ImageFormatRg16i
  &Vk.FORMAT_R16G16_SFLOAT => SPIRV.ImageFormatRg16f
  &Vk.FORMAT_R16G16B16A16_UNORM => SPIRV.ImageFormatRgba16
  &Vk.FORMAT_R16G16B16A16_SNORM => SPIRV.ImageFormatRgba16Snorm
  &Vk.FORMAT_R16G16B16A16_UINT => SPIRV.ImageFormatRgba16ui
  &Vk.FORMAT_R16G16B16A16_SINT => SPIRV.ImageFormatRgba16i
  &Vk.FORMAT_R16G16B16A16_SFLOAT => SPIRV.ImageFormatRgba16f
  &Vk.FORMAT_R32_UINT => SPIRV.ImageFormatR32ui
  &Vk.FORMAT_R32_SINT => SPIRV.ImageFormatR32i
  &Vk.FORMAT_R32_SFLOAT => SPIRV.ImageFormatR32f
  &Vk.FORMAT_R32G32_UINT => SPIRV.ImageFormatRg32ui
  &Vk.FORMAT_R32G32_SINT => SPIRV.ImageFormatRg32i
  &Vk.FORMAT_R32G32_SFLOAT => SPIRV.ImageFormatRg32f
  &Vk.FORMAT_R32G32B32A32_UINT => SPIRV.ImageFormatRgba32ui
  &Vk.FORMAT_R32G32B32A32_SINT => SPIRV.ImageFormatRgba32i
  &Vk.FORMAT_R32G32B32A32_SFLOAT => SPIRV.ImageFormatRgba32f
  &Vk.FORMAT_R64_UINT => SPIRV.ImageFormatR64ui
  &Vk.FORMAT_R64_SINT => SPIRV.ImageFormatR64i
  &Vk.FORMAT_B10G11R11_UFLOAT_PACK32 => SPIRV.ImageFormatR11fG11fB10f
  &Vk.FORMAT_UNDEFINED => SPIRV.ImageFormatUnknown
  _ => error("Unknown Vulkan image format $vk_format")
end

SPIRV.ImageFormat(T::DataType) = SPIRV.ImageFormat(Vk.Format(T))

end
