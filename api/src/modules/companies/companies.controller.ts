import { Controller, Get, Param, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { CompaniesEntity } from './companies.entity';
import { CompaniesService } from './companies.service';
@Controller('companies')
@ApiTags('companies')
export class CompaniesController {
  constructor(private companiesService: CompaniesService) {}

  @Get('/:id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  public async getCompany(@Param('id') id: string): Promise<CompaniesEntity> {
    const company = await this.companiesService.findById(id);
    return company;
  }
}
